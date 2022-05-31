terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "us-west-1"
    profile = "cxtrade-dev"
    key     = "terraformstatefile"
    bucket  = "cxtrade-dev-tfstatebucket10122021"
  }
}
