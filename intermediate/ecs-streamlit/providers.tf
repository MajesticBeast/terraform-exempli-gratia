provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.assume_role_name}"
  }
}

