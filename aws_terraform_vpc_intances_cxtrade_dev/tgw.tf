# Create TGW
resource "aws_ec2_transit_gateway" "tf_cxtrade_tgw" {
  provider          = aws.region
  description = "CXTRADE Transit Gateway"
  amazon_side_asn = var.tgw_asn
  tags = {
    Name = "tf_cxtrade_tgw"
  }
}

# Create Cantor GUI Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tf_tgw_attach_cantor_gui" {
  provider          = aws.region
  subnet_ids         = [aws_subnet.tf_tgw_attach_subnet_guia.id, aws_subnet.tf_tgw_attach_subnet_guib.id, aws_subnet.tf_tgw_attach_subnet_guic.id]
  transit_gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  vpc_id             = aws_vpc.tf_cantor_gui.id
  tags = {
    Name = "tf_tgw_attach_cantor_gui"
  }
}

# Create Cantor QA Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tf_tgw_attach_cantor_qa" {
  provider          = aws.region
  subnet_ids         = [aws_subnet.tf_tgw_attach_subnet_qaa.id, aws_subnet.tf_tgw_attach_subnet_qab.id, aws_subnet.tf_tgw_attach_subnet_qac.id]
  transit_gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  vpc_id             = aws_vpc.tf_cantor_qa.id
  tags = {
    Name = "tf_tgw_attach_cantor_qa"
  }
}

# Create Cantor teamcity Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tf_tgw_attach_cantor_teamcity" {
  provider          = aws.region
  subnet_ids         = [aws_subnet.tf_tgw_attach_subnet_teamcitya.id, aws_subnet.tf_tgw_attach_subnet_teamcityb.id, aws_subnet.tf_tgw_attach_subnet_teamcityc.id]
  transit_gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  vpc_id             = aws_vpc.tf_cantor_teamcity.id
  tags = {
    Name = "tf_tgw_attach_cantor_teamcity"
  }
}

# Create Cantor OpsWork Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tf_tgw_attach_cantor_opswork_scm" {
  provider          = aws.region
  subnet_ids         = [aws_subnet.tf_tgw_attach_subnet_opswork_scma.id, aws_subnet.tf_tgw_attach_subnet_opswork_scmb.id, aws_subnet.tf_tgw_attach_subnet_opswork_scmc.id]
  transit_gateway_id = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  vpc_id             = aws_vpc.tf_cantor_opswork_scm.id
  tags = {
    Name = "tf_tgw_attach_cantor_opswork_scm"
  }
}