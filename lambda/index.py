import json
import boto3
import os

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'CloudDictionary')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Log the entire event for deep debugging
    print(f"Received event: {json.dumps(event)}")

    # Extract the search term from the query string (?term=S3)
    query_params = event.get('queryStringParameters')
    
    if not query_params or 'term' not in query_params:
        print("Error: No search term provided in query parameters.")
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*', # Required for CORS
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': 'Please provide a search term'})
        }

    # Normalize the term: Trim spaces and convert to uppercase to match DB
    raw_term = query_params['term']
    search_term = raw_term.strip().upper()
    print(f"Searching for Term: {search_term} (Original: {raw_term})")

    try:
        # Query DynamoDB using the exact case-sensitive key 'Term'
        response = table.get_item(Key={'Term': search_term})
        
        if 'Item' in response:
            print(f"Success: Found definition for {search_term}")
            return {
                'statusCode': 200,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps(response['Item'])
            }
        else:
            # Explicitly return a message the frontend can display
            print(f"Not Found: {search_term} does not exist in {table_name}")
            return {
                'statusCode': 404,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({'message': f"'{search_term}' not found in dictionary."})
            }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': 'Internal server error'})
        }