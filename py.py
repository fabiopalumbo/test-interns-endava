import boto3
import json

def lambda_handler(event, context):
    bucket = event['bucket']
    key = event['key']
    s3 = boto3.client('s3')
    response = s3.get_object(Bucket='mnl-endava-bucket', Key='text.txt')
    return print(response['Body'].read().decode('utf-8'))