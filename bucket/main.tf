resource "aws_s3_bucket" "testBucketEliel"{
bucket = "bucket-text-eliel"
  tags= {
    Name= "Texto S3 Eliel"
 }

}

resource "aws_s3_object" "textFile"{
    for_each = fileset("./documents/","**")
    bucket = aws_s3_bucket.testBucketEliel.id
    key = each.value
    #source = "./text.txt"
    source = "./documents/${each.value}"

}

resource "aws_s3_bucket_acl" "textoS3acl"{
    bucket = aws_s3_bucket.testBucketEliel.id
    acl ="private"
}