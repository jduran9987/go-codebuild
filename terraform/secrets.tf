data "aws_secretsmanager_secret" "github" {
  arn = "arn:aws:secretsmanager:us-east-1:747289661046:secret:githubToken-HotrDC"
}

data "aws_secretsmanager_secret_version" "github" {
  secret_id = data.aws_secretsmanager_secret.github.id
}