resource "aws_api_gateway_method" "delete_todo" {
  rest_api_id   = "${aws_api_gateway_rest_api.ToDosAPI.id}"
  resource_id   = "${aws_api_gateway_resource.ID.id}"
  http_method   = "DELETE"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "delete_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.ToDosAPI.id}"
  resource_id   = "${aws_api_gateway_resource.ID.id}"
  http_method             = "${aws_api_gateway_method.delete_todo.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.delete_lambda.invoke_arn}"
}

resource "aws_lambda_permission" "delete_apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.delete_lambda.function_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.ToDosAPI.id}/*/*"
}

resource "aws_api_gateway_method_response" "delete_response_200" {
  rest_api_id = "${aws_api_gateway_rest_api.ToDosAPI.id}"
  resource_id   = "${aws_api_gateway_resource.ID.id}"
  http_method = "${aws_api_gateway_method.delete_todo.http_method}"
  status_code = "200"
  response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = true
    }
  response_models = {
      "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "deleteIntegrationResponse" {
  rest_api_id = "${aws_api_gateway_rest_api.ToDosAPI.id}"
  resource_id   = "${aws_api_gateway_resource.ID.id}"
  http_method = "${aws_api_gateway_method.delete_todo.http_method}"
  status_code = "${aws_api_gateway_method_response.delete_response_200.status_code}"
  depends_on = ["aws_api_gateway_integration.delete_integration"]
  response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}