terraform {
    backend "s3" {}
}

provider "aws" {
    profile = var.aws_profile 
    region = var.aws_region 
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}



locals {
    prefix = "${var.name}-${var.environment}"
    
    aws_partition = data.aws_partition.current.partition
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region = data.aws_region.current.name

    tags = {
        Environment = var.environment
        Application = var.name
    }
}
