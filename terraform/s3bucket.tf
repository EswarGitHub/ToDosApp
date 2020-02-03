provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


resource "aws_s3_bucket" "todos-bucket528491" {
  bucket = "todos-bucket528491"
  acl    = "public-read"
  policy = "${file("policy.json")}"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  provisioner "local-exec" {
    command = "cd .. && REACT_APP_URL=${aws_api_gateway_deployment.ToDosDeployment.invoke_url} yarn build"
  }
}