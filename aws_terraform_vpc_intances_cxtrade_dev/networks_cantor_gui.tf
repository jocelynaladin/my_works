# Create Cantor GUI vpc
resource "aws_vpc" "tf_cantor_gui" {
  provider             = aws.region
  cidr_block           = "10.251.82.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf_cantor_gui"
  }
}

# Create IGW for Cantor GUI
resource "aws_internet_gateway" "tf_igw_cantor_gui" {
  provider = aws.region
  vpc_id   = aws_vpc.tf_cantor_gui.id
  tags = {
    Name = "tf_igw_cantor_gui"
  }
}

# # Get all available AZ's in VPC for region
# data "aws_availability_zones" "azs" {
#   provider = aws.region
#   state    = "available"
# }

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_guia" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.96/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_guia"
  }
}

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_guib" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.128/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_guib"
  }
}

# Create GUI public subnet 
resource "aws_subnet" "tf_public_subnet_guic" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.160/27"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_public_subnet_guic"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_guia" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.0/27"
  tags = {
    Name = "tf_private_subnet_guia"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_guib" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.32/27"
  tags = {
    Name = "tf_private_subnet_guib"
  }
}

# Create GUI private subnet 
resource "aws_subnet" "tf_private_subnet_guic" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.64/27"
  tags = {
    Name = "tf_private_subnet_guic"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_guia" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.192/28"
  tags = {
    Name = "tf_tgw_attach_subnet_guia"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_guib" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.208/28"
  tags = {
    Name = "tf_tgw_attach_subnet_guib"
  }
}

# Create GUI tgw subnet 
resource "aws_subnet" "tf_tgw_attach_subnet_guic" {
  provider          = aws.region
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  vpc_id            = aws_vpc.tf_cantor_gui.id
  cidr_block        = "10.251.82.224/28"
  tags = {
    Name = "tf_tgw_attach_subnet_guic"
  }
}

# # Overwrite default route table of VPC(Master) with our route table entries
# resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
#   provider       = aws.region
#   vpc_id         = aws_vpc.vpc_master.id
#   route_table_id = aws_route_table.internet_route.id
# }

# # Create route table
# resource "aws_route_table" "tf_cantor_gui_route" {
#   provider = aws.region
#   vpc_id   = aws_vpc.tf_cantor_gui.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.tf_igw_cantor_gui.id
#   }

#   lifecycle {
#     ignore_changes = all
#   }

#   tags = {
#     Name = "tf_cantor_gui_route"
#   }
# }

# # Overwrite default route table of VPC(Master) with our route table entries
# resource "aws_main_route_table_association" "tf_set_cantor_gui_default_rt_assoc" {
#   provider       = aws.region
#   vpc_id         = aws_vpc.tf_cantor_gui.id
#   route_table_id = aws_route_table.tf_cantor_gui_route.id
# }

# resource "aws_default_route_table" "tf_cantor_gui_default_rt_table" {
#   provider               = aws.region
#   default_route_table_id = aws_vpc.tf_cantor_gui.default_route_table_id

#   route {
#       cidr_block = "0.0.0.0/0"
#       gateway_id = aws_internet_gateway.tf_igw_cantor_gui.id
#   }

#   tags = {
#     Name = "tf_cantor_gui_default_rt_table"
#   }
# }

resource "aws_eip" "tf_cantor_gui_eip" {
  provider               = aws.region
  vpc              = true
}

resource "aws_nat_gateway" "tf_cantor_gui_nat_gw" {
  provider               = aws.region
  allocation_id = aws_eip.tf_cantor_gui_eip.id
  subnet_id     = aws_subnet.tf_public_subnet_guia.id

  tags = {
    Name = "tf_cantor_gui_nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.tf_igw_cantor_gui]
}