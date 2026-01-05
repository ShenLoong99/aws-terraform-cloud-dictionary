import json
import boto3
import os

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'CloudDictionary')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Extract the search term from the query string (?term=S3)
    query_params = event.get('queryStringParameters')
    
    if not query_params or 'term' not in query_params:
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*', # Required for CORS
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': 'Please provide a search term'})
        }

    # Normalize the term: Trim spaces and convert to uppercase to match DB
    search_term = query_params['term'].strip().upper()

    try:
        # Query DynamoDB using the exact case-sensitive key 'Term'
        response = table.get_item(Key={'Term': search_term})
        
        if 'Item' in response:
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