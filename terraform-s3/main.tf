#can be used to randomize bucket name with intergers
/*resource "random_integer" "num" {
    max = 100
    min = 1
}
# random interger is used inside the bucket name randomizing the naming convention with integers
resource "aws_s3_bucket" "myapp-backend" {
  bucket = "bootcamp30-${random_integer.num.result}-fru"

  tags = {
    Name  = "Terraform Backend"
    Environment = "Dev"
  }
}*/
# creates a random bucket name with a randomized pet name each time a new bucket is created.
 resource "random_pet" "pet_name" {
    prefix = var.bucket_name
    length = 2
}
# randomized bucket name conventoin is used as shown in the bucket name.
 resource "aws_s3_bucket" "myapp-backend" {
  bucket = random_pet.pet_name.id
  count = 2

  tags = {
    Name  = "Terraform Backend  "
    Environment = "Dev"
  } 
}
 resource "aws_kms_key" "mykey" {
  description = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket_server_side_encryption_configuration" "myapp-bucket" {
  bucket = aws_s3_bucket.myapp-backend[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

