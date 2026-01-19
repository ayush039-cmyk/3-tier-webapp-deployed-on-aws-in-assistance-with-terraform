resource "aws_vpc" "myvpc" {
   cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
}
