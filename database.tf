# This table will store our "Cloud Terms" as the Partition Key.
resource "aws_dynamodb_table" "dictionary_table" {
  name         = "CloudDictionary"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Term"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "Term"
    type = "S"
  }
}

# Resource to insert each item into DynamoDB
resource "aws_dynamodb_table_item" "dictionary_items" {
  for_each   = var.cloud_terms
  table_name = aws_dynamodb_table.dictionary_table.name
  hash_key   = "Term" # Changed from "term" to "Term"

  item = jsonencode({
    "Term"       = { "S" : upper(each.key) } # Use capital T
    "Definition" = { "S" : each.value }
  })
}