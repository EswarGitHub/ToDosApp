provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


resource "aws_s3_bucket" "todos-bucket528491" {
  bucket = "todos-bucket528491"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}