output "input_stream_name" {
    value = aws_kinesis_stream.input.name
}

output "output_stream_name" {
    value = aws_kinesis_stream.output.name
}

output "analytics_application_name" {
    value = aws_kinesisanalyticsv2_application.app.name
}