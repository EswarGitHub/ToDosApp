resource "aws_lambda_function" "get_lambda" {
  filename      = "get.zip"
  function_name = "get_lambda"
  role          = "${aws_iam_role.manage_todos.arn}"
  handler       = "main"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("get.zip")}"

  runtime = "go1.x"
}

resource "aws_lambda_function" "post_lambda" {
  filename      = "post.zip"
  function_name = "post_lambda"
  role          = "${aws_iam_role.manage_todos.arn}"
  handler       = "main"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("post.zip")}"

  runtime = "go1.x"
}

resource "aws_lambda_function" "put_lambda" {
  filename      = "put.zip"
  function_name = "put_lambda"
  role          = "${aws_iam_role.manage_todos.arn}"
  handler       = "main"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("put.zip")}"

  runtime = "go1.x"
}

resource "aws_lambda_function" "delete_lambda" {
  filename      = "delete.zip"
  function_name = "delete_lambda"
  role          = "${aws_iam_role.manage_todos.arn}"
  handler       = "main"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("delete.zip")}"

  runtime = "go1.x"
}
