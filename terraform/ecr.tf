resource "aws_ecr_repository" "golang" {
  name                 = "golang"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}