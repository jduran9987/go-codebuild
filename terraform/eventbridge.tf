# resource "aws_cloudwatch_event_rule" "weekly_codebuild" {
#   name = "friday-weekly-codebuild"
#   event_bus_name = "default"
#   schedule_expression = "cron(*/10 * ? * MON-FRI *)"
#   is_enabled = true
# }