terraform {
  backend "s3" {
    bucket         = "state-bucket-dev-tramntb"     # your S3 bucket name
    key            = "dev/terraform.tfstate"       # path to state file inside the bucket
    region         = "ap-northeast-1"              # same region as your bucket
    dynamodb_table = "terraform-locks-dev-tramntb"  # DynamoDB table name for locking
    encrypt        = true                          # encrypt state at rest
  }
}