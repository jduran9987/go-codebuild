# resource "aws_cloudwatch_event_rule" "weekly_codebuild" {
#   name = "friday-weekly-codebuild"
#   event_bus_name = "default"
#   schedule_expression = "cron(*/10 * ? * MON-FRI *)"
#   is_enabled = true
#   role_arn = aws_iam_role.codebuild.arn
# }

# resource "aws_cloudwatch_event_target" "codebuild" {
#   rule = aws_cloudwatch_event_rule.weekly_codebuild.name
#   arn = aws_codebuild_project.golang.arn 
#   role_arn = aws_iam_role.codebuild.arn
# }