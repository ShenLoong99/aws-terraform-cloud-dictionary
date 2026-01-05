# This table will store our "Cloud Terms" as the Partition Key.
resource "aws_dynamodb_table" "dictionary_table" {
  name         = "CloudDictionary"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Term"

  attribute {
    name = "Term"
    type = "S"
  }

  tags = {
    Project = "CloudDictionary"
  }
}