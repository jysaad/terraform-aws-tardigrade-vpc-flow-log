provider aws {
  region = "us-east-1"
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.15.0"

  providers = {
    aws = aws
  }

  name = "tardigrade-vpc-flow-log-testing"
  cidr = "10.0.0.0/16"
}

module "baseline_s3" {
  source = "../../"
  providers = {
    aws = aws
  }

  create_vpc_flow_log  = true
  vpc_id               = module.vpc.vpc_id
  log_destination_type = "cloud-watch-logs"
}
