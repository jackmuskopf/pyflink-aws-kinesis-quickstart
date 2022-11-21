resource "aws_kinesis_stream" "input" {
  name             = "${local.prefix}-input"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = local.tags
}

resource "aws_kinesis_stream" "output" {
  name             = "${local.prefix}-output"
  shard_count      = var.output_shards
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = local.tags
}