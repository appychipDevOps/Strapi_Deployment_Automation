
resource "aws_security_group" "strapi_sg" {
  name        = var.instance_security_group_name
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.inbound_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "strapi_sg"
  }
}