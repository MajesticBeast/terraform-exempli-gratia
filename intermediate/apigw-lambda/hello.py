import json

def lambda_handler(event, context):
    # TODO implement
    name = event['pathParameters']['name']
    return {
        'statusCode': 200,
        'body': json.dumps(f'Hello {name}!')
    }
