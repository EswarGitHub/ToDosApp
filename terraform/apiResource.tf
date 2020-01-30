resource "aws_api_gateway_resource" "ID" {
  rest_api_id = "${aws_api_gateway_rest_api.ToDosAPI.id}"
  parent_id   = "${aws_api_gateway_rest_api.ToDosAPI.root_resource_id}"
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "ID_options_method" {
    rest_api_id   = "${aws_api_gateway_rest_api.ToDosAPI.id}"
    resource_id   = "${aws_api_gateway_resource.ID.id}"
    http_method   = "OPTIONS"
    authorization = "NONE"
}

resource "aws_api_gateway_method_response" "ID_options_200" {
    rest_api_id   = "${aws_api_gateway_rest_api.ToDosAPI.id}"
    resource_id   = "${aws_api_gateway_resource.ID.id}"
    http_method   = "${aws_api_gateway_method.ID_options_method.http_method}"
    status_code   = 200
    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true,
        "method.response.header.Access-Control-Allow-Methods" = true,
        "method.response.header.Access-Control-Allow-Origin" = true
    }
    depends_on = ["aws_api_gateway_method.ID_options_method"]
}

resource "aws_api_gateway_integration" "ID_options_integration" {
    rest_api_id   = "${aws_api_gateway_rest_api.ToDosAPI.id}"
    resource_id   = "${aws_api_gateway_resource.ID.id}"
    http_method   = "${aws_api_gateway_method.ID_options_method.http_method}"
    type          = "MOCK"
    passthrough_behavior = "WHEN_NO_MATCH"
    request_templates = {
        "application/json" = "{ 'statusCode': 200 }"
    }
    depends_on = ["aws_api_gateway_method.ID_options_method"]
}

resource "aws_api_gateway_integration_response" "ID_options_integration_response" {
    rest_api_id   = "${aws_api_gateway_rest_api.ToDosAPI.id}"
    resource_id   = "${aws_api_gateway_resource.ID.id}"
    http_method   = "${aws_api_gateway_method.ID_options_method.http_method}"
    status_code   = "${aws_api_gateway_method_response.ID_options_200.status_code}"
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,DELETE,PUT'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
    depends_on = ["aws_api_gateway_method_response.ID_options_200"]
}