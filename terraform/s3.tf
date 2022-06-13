resource "aws_s3_bucket" "cache" {
  count = 1
  bucket = "${local.account_id}-codebuild"
}

resource "aws_s3_bucket_acl" "cache" {
  bucket = aws_s3_bucket.cache.id
  acl    = "private"
}

