variable "profile" {
  type    = string
  default = "cxtrade-dev"
}

# The Region you want to deploy your resources
# Change the default value to deploy to a specific region
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpn_asn" {
  type    = number
  default = 19602
}

variable "tgw_asn" {
  type    = number
  default = 64588
}

variable "public_subnet_gui" {
  description = "Map of GUI subnet"
  type        = map(any)
  default = {
    tf_public_subnet_guia = "10.251.81.96/27",
    tf_public_subnet_guib = "10.251.81.128/27",
    tf_public_subnet_guic = "10.251.81.160/27"
  }
}

variable "private_subnet_gui" {
  description = "Map of GUI subnet"
  type        = map(any)
  default = {
    tf_private_subnet_guia = "10.251.81.0/27",
    tf_private_subnet_guib = "10.251.81.32/27",
    tf_private_subnet_guic = "10.251.81.64/27"
  }
}

variable "tgw_attach_subnet_gui" {
  description = "Map of GUI subnet"
  type        = map(any)
  default = {
    tf_tgw_attach_subnet_guia = "10.251.81.192/29",
    tf_tgw_attach_subnet_guib = "10.251.81.200/29",
    tf_tgw_attach_subnet_guic = "10.251.81.208/29"
  }
}

# variable "public_subnet_gui" {
#   description = "Available cidr blocks for public subnets"
#   type        = map(any)
#   default = [
#     "10.0.1.0/24",
#     "10.0.2.0/24",
#     "10.0.3.0/24",
#     "10.0.4.0/24",
#     "10.0.5.0/24",
#     "10.0.6.0/24",
#     "10.0.7.0/24",
#     "10.0.8.0/24",
#     "10.0.9.0/24",
#     "10.0.10.0/24",
#     "10.0.11.0/24",
#     "10.0.12.0/24",
#     "10.0.13.0/24",
#     "10.0.14.0/24",
#     "10.0.15.0/24",
#     "10.0.16.0/24"
#   ]
# }

# variable "private_subnet_cidr_blocks" {
#   description = "Available cidr blocks for private subnets"
#   type        = list(string)
#   default = [
#     "10.0.101.0/24",
#     "10.0.102.0/24",
#     "10.0.103.0/24",
#     "10.0.104.0/24",
#     "10.0.105.0/24",
#     "10.0.106.0/24",
#     "10.0.107.0/24",
#     "10.0.108.0/24",
#     "10.0.109.0/24",
#     "10.0.110.0/24",
#     "10.0.111.0/24",
#     "10.0.112.0/24",
#     "10.0.113.0/24",
#     "10.0.114.0/24",
#     "10.0.115.0/24",
#     "10.0.116.0/24"
#   ]
# }


