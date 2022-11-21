# !/bin/bash
terraform destroy --var-file jack.tfvars --target=aws_kinesisanalyticsv2_application.check_env
terraform destroy --var-file jack.tfvars --target=aws_kinesisanalyticsv2_application.analytics
terraform destroy --var-file jack.tfvars --target=aws_kinesis_stream.input
terraform destroy --var-file jack.tfvars --target=aws_kinesis_stream.output