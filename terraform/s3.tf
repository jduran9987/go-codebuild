resource "aws_s3_bucket" "cache" {
  bucket = "${local.account_id}-codebuild"
}

resource "aws_s3_bucket_acl" "cache" {
  bucket = aws_s3_bucket.cache.id
  acl    = "private"
}

