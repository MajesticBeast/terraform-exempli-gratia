resource "aws_budgets_budget" "budget" {
  name = "MainBudget"

  budget_type  = "COST"
  limit_amount = var.budget_limit
  limit_unit   = var.budget_limit_unit
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "FORECASTED"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = var.subscriber_email_addresses
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    subscriber_email_addresses = var.subscriber_email_addresses
  }
}

