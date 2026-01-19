resource "aws_security_group" "pub_sg" {
   name = "allow"
   description = "this is a public security group"
   vpc_id = aws_vpc.myvpc.id

   tags = {
     Name = "my-pub-sg"
   }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
  security_group_id = aws_security_group.pub_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  for_each = toset(["80","443","22"])
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow-exit" {
  security_group_id = aws_security_group.pub_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "pvt_sg" {
   name = "allow1"
   description = "this is a private security group"
   vpc_id = aws_vpc.myvpc.id
   
   tags = {
     Name = "my-pvt-sg"
   }
}

resource "aws_vpc_security_group_ingress_rule" "allow__ipv4" {
   security_group_id = aws_security_group.pvt_sg.id
   cidr_ipv4 = "0.0.0.0/0"
   from_port = "22"
   ip_protocol = "tcp"
   to_port = "22"
}

resource "aws_vpc_security_group_egress_rule" "allow__exit" {
  security_group_id = aws_security_group.pvt_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.pub_sg.id, aws_security_group.pvt_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

