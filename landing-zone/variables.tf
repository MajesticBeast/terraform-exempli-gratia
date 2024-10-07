############################################
# global
############################################
variable "aws_region" {
    description = "The AWS region"
    type        = string
}

############################################
# budgets.tf
############################################
variable "budget_limit" {
  description = "The budget limit amount"
  type        = number
  default     = 100
}

variable "budget_limit_unit" {
  description = "The budget limit unit"
  type        = string
  default     = "USD"
}

variable "subscriber_email_addresses" {
  description = "The email addresses to notify"
  type        = list(string)
}

############################################
# organizations.tf
############################################
variable "dev_account_email" {
  description = "The email address for the dev account"
  type        = string
}

variable "test_account_email" {
  description = "The email address for the test account"
  type        = string
}

variable "qa_account_email" {
  description = "The email address for the qa account"
  type        = string
}

variable "prod_account_email" {
  description = "The email address for the prod account"
  type        = string
}

############################################
# identity_center.tf
############################################
variable "admin_display_name" {
  description = "The display name for the admin user"
  type        = string
}

variable "admin_email" {
  description = "The email address for the admin user"
  type        = string
}

variable "admin_timezone" {
  description = "The timezone for the admin user"
  type        = string
}