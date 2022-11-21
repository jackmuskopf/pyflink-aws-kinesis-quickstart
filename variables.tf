variable "name" {
    default = "qrs-kinesis"
}

variable "environment" {
    default = "dev"
}

variable "aws_region" {
    default = "us-west-1"
}

variable "aws_profile" {
    default = "default"
}

variable "source_code_bucket" {
    description = "Bucket with flink app source"
}

variable "source_code_zip" {
    default = "pkg.zip"
}

variable "output_shards" {
    default = 1
}