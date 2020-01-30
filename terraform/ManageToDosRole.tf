resource "aws_iam_role" "manage_todos" {
  name = "manage_todos"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "db_read_write_policy" {
  name = "db_read_write_policy"
  role = "${aws_iam_role.manage_todos.id}"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem",
                "dynamodb:CreateTable",
                "dynamodb:UpdateTable"
            ],
            "Resource": "${aws_dynamodb_table.basic-dynamodb-table.arn}"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeReservedCapacityOfferings",
                "dynamodb:DescribeReservedCapacity",
                "dynamodb:PurchaseReservedCapacityOfferings",
                "dynamodb:DescribeLimits",
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "attach_db_policy" {
  role       = "${aws_iam_role.manage_todos.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}