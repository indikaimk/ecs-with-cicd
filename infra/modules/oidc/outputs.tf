output "oidc_provider_arn" {
  description = "The ARN of the GitHub OIDC Provider"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "github_actions_role_arn" {
  description = "The ARN of the IAM Role for GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}
