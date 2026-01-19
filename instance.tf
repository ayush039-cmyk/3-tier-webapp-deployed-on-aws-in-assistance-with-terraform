resource "aws_key_pair" "mykey" {
  public_key = file("~/.ssh/terrakey.pub")
  key_name = "mykey"
}

data "aws_ami" "myami" {
  most_recent = true
   
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "ec2_1" {
  ami = data.aws_ami.myami.id
  instance_type = "c7i-flex.large"
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.pub_sg.id]
  subnet_id = aws_subnet.pubsub1.id
  associate_public_ip_address = true
  
  tags = {
    Name = "app tier instance"
  }
}

resource "aws_instance" "ec2_2" {
  ami = data.aws_ami.myami.id
  instance_type = "c7i-flex.large"
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.pvt_sg.id]
  subnet_id = aws_subnet.pvtsub1.id
  
 tags = {
    Name = "web tier instance"
  }
}
