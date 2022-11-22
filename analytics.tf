
# main (Java)
# https://docs.aws.amazon.com/kinesisanalytics/latest/java/get-started-exercise.html

# python
# https://docs.aws.amazon.com/kinesisanalytics/latest/java/gs-python-createapp.html

locals {
    source_md5 = filemd5(var.source_code_zip)
    s3_bucket_key = "${local.prefix}-pkgs/${local.source_md5}.zip"
}

resource "aws_cloudwatch_log_group" "group" {
  name = "${local.prefix}-analytics"
}

resource "aws_cloudwatch_log_stream" "stream" {
  name           = "${local.prefix}-analytics"
  log_group_name = aws_cloudwatch_log_group.group.name
}

data "aws_s3_bucket" "source_code" {
    bucket = var.source_code_bucket
}

resource "aws_s3_object" "source_code" {
  bucket = data.aws_s3_bucket.source_code.bucket
  key    = local.s3_bucket_key
  source = var.source_code_zip
  etag = local.source_md5
}

resource "aws_kinesisanalyticsv2_application" "app" {
  name                   = "${local.prefix}-app"
  runtime_environment    = "FLINK-1_13"
  service_execution_role = aws_iam_role.analytics.arn
  start_application      = true

  application_configuration {
    application_code_configuration {
      code_content {
        s3_content_location {
          bucket_arn = data.aws_s3_bucket.source_code.arn
          file_key   = aws_s3_object.source_code.id
        }
      }

      code_content_type = "ZIPFILE"
    }

    environment_properties {

        property_group {
            property_group_id = "kinesis.analytics.flink.run.options"
            property_map = {
                python = "pkg/src/check-environment.py",
                jarfile = "pkg/jars/flink-sql-connector-kinesis_2.12-1.13.2.jar"
                pyFiles = "pkg/pydeps/"
            }
        }

        property_group {
            property_group_id = "consumer.config.0"
            property_map = {
                "input.stream.name" = aws_kinesis_stream.input.name
                "flink.stream.initpos" = "LATEST"
                "aws.region" = local.aws_region
            }
        }

        property_group {
            property_group_id = "producer.config.0"
            property_map = {
                "output.stream.name" = aws_kinesis_stream.output.name
                "shard.count" = tostring(var.output_shards)
                "aws.region" = local.aws_region
            }
        }
    }

    flink_application_configuration {
      checkpoint_configuration {
        configuration_type = "DEFAULT"
      }

      monitoring_configuration {
        configuration_type = "CUSTOM"
        log_level          = "INFO"
        metrics_level      = "TASK"
      }

      parallelism_configuration {
        auto_scaling_enabled = true
        configuration_type   = "CUSTOM"
        parallelism          = 1
        parallelism_per_kpu  = 1
      }
    }
  }

  cloudwatch_logging_options {
    log_stream_arn = aws_cloudwatch_log_stream.stream.arn
  }

  tags = local.tags
}