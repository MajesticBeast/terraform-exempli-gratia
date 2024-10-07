resource "aws_organizations_organization" "organization" {
  feature_set          = "ALL"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
  aws_service_access_principals = [
    "sso.amazonaws.com"
  ]
}
# TODO: Assign DenyLargeEC2AndRDSInstances policy to the organization
resource "aws_organizations_policy" "policy" {
  depends_on = [aws_organizations_organization.organization]
  name        = "DenyLargeEC2AndRDSInstances"
  description = "Deny the creation of large EC2 and RDS instances"
  type        = "SERVICE_CONTROL_POLICY"
  content     = data.aws_iam_policy_document.deny_large_ec2_and_rds_instances.json
}

resource "aws_organizations_organizational_unit" "nonprod" {
  name      = "nonprod"
  parent_id = aws_organizations_organization.organization.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "prod"
  parent_id = aws_organizations_organization.organization.roots[0].id
}

resource "aws_organizations_account" "dev" {
  name              = "dev"
  email             = var.dev_account_email
  close_on_deletion = true
  parent_id         = aws_organizations_organizational_unit.nonprod.id
}

resource "aws_organizations_account" "test" {
  name              = "test"
  email             = var.test_account_email
  close_on_deletion = true
  parent_id         = aws_organizations_organizational_unit.nonprod.id
}

resource "aws_organizations_account" "qa" {
  name              = "qa"
  email             = var.qa_account_email
  close_on_deletion = true
  parent_id         = aws_organizations_organizational_unit.prod.id
}

resource "aws_organizations_account" "prod" {
  name              = "prod"
  email             = var.prod_account_email
  close_on_deletion = true
  parent_id         = aws_organizations_organizational_unit.prod.id
}

data "aws_iam_policy_document" "deny_large_ec2_and_rds_instances" {
  statement {
    sid    = "DenyLargeEC2Instances"
    effect = "Deny"
    actions = [
      "ec2:RunInstances"
    ]
    resources = ["*"]
    condition {
      test     = "NumericGreaterThan"
      variable = "ec2:Memory"
      values   = ["16"]
    }
  }

  statement {
    sid    = "DenyLargeRDSInstances"
    effect = "Deny"
    actions = [
      "rds:CreateDBInstance"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "rds:DBInstanceClass"
      values = [
        "db.m5.24xlarge",
        "db.r5.24xlarge"
      ]
    }
  }
}