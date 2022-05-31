# Create CXTRADE Customer Gateway

resource "aws_customer_gateway" "tf_cxtrade_cgw_nj2x" {
  provider          = aws.region
  bgp_asn    = var.vpn_asn
  ip_address = "148.106.2.135"
  type       = "ipsec.1"

  tags = {
    Name = "tf_cxtrade_cgw_nj2x"
  }
}

resource "aws_customer_gateway" "tf_cxtrade_cgw_trumbull" {
  provider          = aws.region
  bgp_asn    = var.vpn_asn
  ip_address = "148.106.4.135"
  type       = "ipsec.1"

  tags = {
    Name = "tf_cxtrade_cgw_trumbull"
  }
}

# Create TGW VPN Attachments for NJ2X And TR

resource "aws_vpn_connection" "tf_tgw_attach_vpn_trumbull" {
  provider            = aws.region
  customer_gateway_id = aws_customer_gateway.tf_cxtrade_cgw_trumbull.id
  transit_gateway_id  = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  type                = aws_customer_gateway.tf_cxtrade_cgw_trumbull.type
  tunnel1_inside_cidr   = "169.254.105.0/30"
  tunnel1_preshared_key = "awscxtrade"
  tunnel1_ike_versions  = ["ikev2"]
  tunnel2_inside_cidr   = "169.254.106.0/30"
  tunnel2_preshared_key = "awscxtrade"
  tunnel2_ike_versions  = ["ikev2"]

  tags = {
    Name = "tf_tgw_attach_vpn_trumbull"
  }
}

resource "aws_ec2_tag" "tf_trumbull_vpn_tgw_attach" {
  provider    = aws.region
  resource_id = aws_vpn_connection.tf_tgw_attach_vpn_trumbull.transit_gateway_attachment_id
  key         = "Name"
  value       = "tf_trumbull_vpn_tgw_attach"
}

resource "aws_vpn_connection" "tf_tgw_attach_vpn_nj2x" {
  provider            = aws.region
  customer_gateway_id = aws_customer_gateway.tf_cxtrade_cgw_nj2x.id
  transit_gateway_id  = aws_ec2_transit_gateway.tf_cxtrade_tgw.id
  type                = aws_customer_gateway.tf_cxtrade_cgw_nj2x.type
  tunnel1_inside_cidr   = "169.254.107.0/30"
  tunnel1_preshared_key = "awscxtrade"
  tunnel1_ike_versions  = ["ikev2"]
  tunnel2_inside_cidr   = "169.254.108.0/30"
  tunnel2_preshared_key = "awscxtrade"
  tunnel2_ike_versions  = ["ikev2"]

  tags = {
    Name = "tf_tgw_attach_vpn_nj2x"
  }
}

resource "aws_ec2_tag" "tf_nj2x_vpn_tgw_attach" {
  provider    = aws.region
  resource_id = aws_vpn_connection.tf_tgw_attach_vpn_nj2x.transit_gateway_attachment_id
  key         = "Name"
  value       = "tf_nj2x_vpn_tgw_attach"
}