// - analytics role - //
resource "aws_iam_role" "analytics" {
  name = "${local.prefix}-analytics"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "kinesisanalytics.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "analytics" {
  role = aws_iam_role.analytics.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadCode",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "${data.aws_s3_bucket.source_code.arn}/${aws_s3_object.source_code.id}"
            ]
        },
        {
            "Sid": "ListCloudwatchLogGroups",
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups"
            ],
            "Resource": [
                "arn:${local.aws_partition}:logs:${local.aws_region}:${local.aws_account_id}:log-group:*"
            ]
        },
        {
            "Sid": "ListCloudwatchLogStreams",
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "${aws_cloudwatch_log_group.group.arn}:log-stream:*"
            ]
        },
        {
            "Sid": "PutLogEvents",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": "${aws_cloudwatch_log_stream.stream.arn}"
        },
        {
            "Sid": "PutKPLMetrics",
            "Effect": "Allow",
            "Resource": "*",
            "Action": "cloudwatch:PutMetricData",
            "Condition": {
                "StringEquals": {
                    "cloudwatch:namespace": "KinesisProducerLibrary"
                }
            }
        },
        {
            "Sid": "ReadInputStream",
            "Effect": "Allow",
            "Action": [
                "kinesis:Describe*",
                "kinesis:Get*",
                "kinesis:List*",
                "kinesis:RegisterStreamConsumer",
                "kinesis:DeregisterStreamConsumer",
                "kinesis:MergeShards",
                "kinesis:SplitShard",
                "kinesis:SubscribeToShard"
            ],
            "Resource": "${aws_kinesis_stream.input.arn}"
        },
        {
            "Sid": "WriteOutputStream",
            "Effect": "Allow",
            "Action": [
                "kinesis:Describe*",
                "kinesis:Get*",
                "kinesis:List*",
                "kinesis:RegisterStreamConsumer",
                "kinesis:DeregisterStreamConsumer",
                "kinesis:MergeShards",
                "kinesis:SplitShard",
                "kinesis:SubscribeToShard",
                "kinesis:PutRecord",
                "kinesis:PutRecords"
            ],
            "Resource": "${aws_kinesis_stream.output.arn}"
        }
    ]
}

EOF
}