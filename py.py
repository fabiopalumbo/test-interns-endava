import boto3

def lambda_handler(event, context):
    # Get the object from the event
    bucket = event['bucket']
    key = event['key']

    # Connect to S3
    s3 = boto3.client('s3')

    # Get the object
    response = s3.get_object(Bucket=bucket, Key=key)

    # Return the message
    return response['Body'].read().decode('utf-8')