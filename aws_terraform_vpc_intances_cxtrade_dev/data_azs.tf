# Get all available AZ's in VPC for region
data "aws_availability_zones" "azs" {
  provider = aws.region
  state    = "available"
}