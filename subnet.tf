resource "aws_subnet" "pubsub1" {
   vpc_id = aws_vpc.myvpc.id
   cidr_block = "10.0.0.0/19"
   
   tags = {
     Name = "public-subnet-1"
   }
}

resource "aws_subnet" "pvtsub1" {
   vpc_id = aws_vpc.myvpc.id
   cidr_block = "10.0.32.0/19"
   availability_zone = "ap-south-1a" 
   tags = {
     Name = "private-subnet-1"
   }
}

resource "aws_subnet" "pvtsub2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.64.0/19"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "my-eip"
   }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.pubsub1.id
  
  tags = {
    Name = "nat-gate"
  }
}
