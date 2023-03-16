resource "aws_dynamodb_table" "example" {
  name           = "Product"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}


resource "aws_lambda_event_source_mapping" "example_event" {
  event_source_arn  = aws_dynamodb_table.example.stream_arn
  function_name     = data.aws_lambda_function.lambdajava.arn
  starting_position = "LATEST"
}