resource "aws_s3_bucket" "mybucket" {
   bucket = "my-bucket001200"
   tags = {
     Name = "my-bucket0010001"
     Environment = "dev"
}
}
