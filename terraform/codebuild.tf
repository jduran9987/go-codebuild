resource "aws_codebuild_project" "golang" {
  name = "golang"
  build_timeout = "5"
  service_role = aws_iam_role.codebuild.arn 

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "S3"
    location = aws_s3_bucket.cache.bucket 
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:1.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true

    environment_variable {
      name = "ECR_IMAGE_REPO"
      value = aws_ecr_repository.golang.repository_url
    }

    environment_variable {
      name = "AWS_ACCOUNT"
      value = "${local.account_id}"
    }

    environment_variable {
      name = "AWS_DEFAULT_REGION"
      value = "us-east-1"
    }
  }

  source {
    type = "GITHUB"
    location = "https://github.com/jduran9987/go-codebuild.git"
    git_clone_depth = 1
  }
}

resource "aws_codebuild_webhook" "github" {
  project_name = aws_codebuild_project.golang.name
  build_type = "BUILD"
  filter_group {
    filter {
      type = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED, PULL_REQUEST_MERGED"
    }

    filter {
      type = "BASE_REF"
      pattern = "^refs/heads/main$"
    }
  }
}

resource "aws_codebuild_source_credential" "example" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = jsondecode(data.aws_secretsmanager_secret_version.github.secret_string)["GITHUB_TOKEN"]
}