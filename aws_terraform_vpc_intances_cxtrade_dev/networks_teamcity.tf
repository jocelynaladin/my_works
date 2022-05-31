# Create Cantor GUI vpc
resource "aws_vpc" "tf_cantor_teamcity" {
  provider             = aws.region
  cidr_block           = "10.251.81.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf_cantor_teamcity"
  }
}


# # Get all available AZ's in VPC for region
# data "aws_availability_zones" "azs" {
#   provider = aws.region
#   state    = "available"
# }

# Create IGW for TeamCity
resource "aws_internet_gateway" "tf_igw_cantor_teamcity" {
  provider = aws.region
  vpc_id   = aws_vpc.tf_cantor_teamcity.id
  tags = {
    Name = "tf_igw_cantor_teamcity"
  }
}

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_teamcitya" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.96/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_teamcitya"
  }
}

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_teamcityb" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.128/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_teamcityb"
  }
}

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_teamcityc" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.160/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_teamcityc"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_teamcitya" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.0/27"
  tags = {
    Name = "tf_private_subnet_teamcitya"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_teamcityb" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.32/27"
  tags = {
    Name = "tf_private_subnet_teamcityb"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_teamcityc" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.64/27"
  tags = {
    Name = "tf_private_subnet_teamcityc"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_teamcitya" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.192/28"
  tags = {
    Name = "tf_tgw_attach_subnet_teamcitya"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_teamcityb" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.208/28"
  tags = {
    Name = "tf_tgw_attach_subnet_teamcityb"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_teamcityc" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_teamcity.id
  cidr_block        = "10.251.81.224/28"
  tags = {
    Name = "tf_tgw_attach_subnet_teamcityc"
  }
}



# # initialising Peering connection request from us-east-1
# resource "aws_vpc_peering_connection" "useast1-uswest2" {
#   provider    = aws.region
#   peer_vpc_id = aws_vpc.vpc_master_oregon.id
#   vpc_id      = aws_vpc.vpc_master.id
#   peer_region = var.region-worker
# }

# # Accept VPC peering request in us-west-2 from us-east-1
# resource "aws_vpc_peering_connection_accepter" "accept_peering" {
#   provider                  = aws.region-worker
#   vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
#   auto_accept               = true
# }

# # Create route table in us-east-1
# resource "aws_route_table" "internet_route" {
#   provider = aws.region
#   vpc_id   = aws_vpc.vpc_master.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   route {
#     cidr_block                = "192.168.1.0/24"
#     vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
#   }

#   lifecycle {
#     ignore_changes = all
#   }

#   tags = {
#     Name = "Master-Region-RT"
#   }
# }

# # Overwrite default route table of VPC(Master) with our route table entries
# resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
#   provider       = aws.region
#   vpc_id         = aws_vpc.vpc_master.id
#   route_table_id = aws_route_table.internet_route.id
# }

# # Create route table in us-west-2
# resource "aws_route_table" "internet_route_oregon" {
#   provider = aws.region-worker
#   vpc_id   = aws_vpc.vpc_master_oregon.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw-oregon.id
#   }

#   route {
#     cidr_block                = "10.0.1.0/24"
#     vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
#   }

#   lifecycle {
#     ignore_changes = all
#   }

#   tags = {
#     Name = "Worker-Region-RT"
#   }
# }

# # Overwrite default route table of VPC(Master) with our route table entries
# resource "aws_main_route_table_association" "set-worker-default-rt-assoc" {
#   provider       = aws.region-worker
#   vpc_id         = aws_vpc.vpc_master_oregon.id
#   route_table_id = aws_route_table.internet_route_oregon.id
# }

# resource "aws_default_route_table" "tf_cantor_teamcity_default_rt_table" {
#   provider               = aws.region
#   default_route_table_id = aws_vpc.tf_cantor_teamcity.default_route_table_id

#   route {
#       cidr_block = "0.0.0.0/0"
#       gateway_id = aws_internet_gateway.tf_igw_cantor_teamcity.id
#   }

#   tags = {
#     Name = "tf_cantor_teamcity_default_rt_table"
#   }
# }

resource "aws_eip" "tf_cantor_teamcity_eip" {
  provider               = aws.region
  vpc              = true
}

resource "aws_nat_gateway" "tf_cantor_teamcity_nat_gw" {
  provider               = aws.region
  allocation_id = aws_eip.tf_cantor_teamcity_eip.id
  subnet_id     = aws_subnet.tf_public_subnet_teamcitya.id

  tags = {
    Name = "tf_cantor_teamcity_nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.tf_igw_cantor_teamcity]
}