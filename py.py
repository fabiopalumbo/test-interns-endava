import boto3

def lambda_handler(event,context):
    s3 = boto3.client('s3')
    response = s3.get_object(Bucket='mnl-endava-bucket', Key='text.txt')
    contenido = response['Body'].read().decode('utf-8')
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': contenido,
        "isBase64Encoded": False
    }