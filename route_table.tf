resource "aws_route_table" "mypub_rt" {
   vpc_id = aws_vpc.myvpc.id
   
   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.my_igw.id
   }
  
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "mypvt_rt" {
  vpc_id = aws_vpc.myvpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
   }
  
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "a" {
   subnet_id = aws_subnet.pubsub1.id
   route_table_id = aws_route_table.mypub_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.pvtsub1.id
  route_table_id = aws_route_table.mypvt_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.pvtsub2.id
  route_table_id = aws_route_table.mypvt_rt.id
}
