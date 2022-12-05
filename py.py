import boto3
import magic


class AWSS3:
    def __init__(self) -> None:
        self.s3_resource = boto3.resource("s3")
        self.bucket = self.s3_resource.Bucket("mnl-endava-bucket")
        self.s3_client = boto3.client("s3")

   
    
    def get_url_location_file(self, key_name: str) -> str:

        response = self.s3_client.generate_presigned_url(
            "get_object",
            Params={
                "Bucket": "mnl-endava-bucket",
                "Key": key_name,
            },
            ExpiresIn=60,
        )
        return str(response)
        
my_s3 = AWSS3()

print(my_s3.get_url_location_file("text.txt"))