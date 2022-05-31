# Create route for TGW on all VPC Main Route Table

# Modify main Route Table Cantor GUIs 
resource "aws_default_route_table" "tf_cantor_gui_default_rt_table" {
  provider               = aws.region
  default_route_table_id = aws_vpc.tf_cantor_gui.default_route_table_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.tf_igw_cantor_gui.id
  }

  route {
      cidr_block = "10.0.0.0/8"
      gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  }

  tags = {
    Name = "tf_cantor_gui_default_rt_table"
  }
  
  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_gui, 
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_qa,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_teamcity,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_opswork_scm
                ]
}

# Modify main Route Table Cantor QA 
resource "aws_default_route_table" "tf_cantor_qa_default_rt_table" {
  provider               = aws.region
  default_route_table_id = aws_vpc.tf_cantor_qa.default_route_table_id

  route {
      cidr_block = "10.0.0.0/8"
      gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  }

  tags = {
    Name = "tf_cantor_qa_default_rt_table"
  }

  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_gui, 
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_qa,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_teamcity,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_opswork_scm
                ]
}

# Modify main Route Table Cantor TeamCity 
resource "aws_default_route_table" "tf_cantor_teamcity_default_rt_table" {
  provider               = aws.region
  default_route_table_id = aws_vpc.tf_cantor_teamcity.default_route_table_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.tf_igw_cantor_teamcity.id
  }

  route {
      cidr_block = "10.0.0.0/8"
      gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  }

  tags = {
    Name = "tf_cantor_teamcity_default_rt_table"
  }

  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_gui, 
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_qa,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_teamcity,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_opswork_scm
                ]
}

# Modify main Route Table Cantor OpsWork SCM
resource "aws_default_route_table" "tf_cantor_opswork_scm_default_rt_table" {
  provider               = aws.region
  default_route_table_id = aws_vpc.tf_cantor_opswork_scm.default_route_table_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.tf_igw_opswork_scm.id
  }

  route {
      cidr_block = "10.0.0.0/8"
      gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  }

  tags = {
    Name = "tf_cantor_opswork_scm_default_rt_table"
  }

  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_gui, 
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_qa,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_teamcity,
                aws_ec2_transit_gateway_vpc_attachment.tf_tgw_attach_cantor_opswork_scm
                ]
}