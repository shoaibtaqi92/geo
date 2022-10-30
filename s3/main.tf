
#Resource to create s3 bucket
resource "aws_s3_bucket" "s3-bucket"{
  bucket = var.bucket

  tags = {
    Name = "S3Bucket"
  }
}

#Resource to enable versioning
resource "aws_s3_bucket_versioning" "versioning_demo" {
  bucket = aws_s3_bucket.s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Resource to enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "demo-encryption" {
  bucket = aws_s3_bucket.s3-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#Adds an ACL to bucket
resource "aws_s3_bucket_acl" "demo_bucket_acl" {
  bucket = aws_s3_bucket.s3-bucket.bucket
  acl    = "private"
}

#Block Public Access
resource "aws_s3_bucket_public_access_block" "demo_public_block" {
  bucket = aws_s3_bucket.s3-bucket.bucket

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3-bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Only allow writes to my bucket with bucket owner full control",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::111122223333:user/ExampleUser"
      },
      "Action": [ "s3:*" ],=
      "Resource": [
        "${aws_s3_bucket.s3-bucket.arn}",
        "${aws_s3_bucket.s3-bucket.arn}/*"
      ],
      "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "bucket_policy_readonly" {
  bucket = aws_s3_bucket.s3-bucket.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicRead",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "${aws_s3_bucket.s3-bucket.arn}",
                "${aws_s3_bucket.s3-bucket.arn}/*"
            ]
        }
    ]
}
EOF
}