data "aws_caller_identity" "current" {}
data "aws_ssoadmin_instances" "idc" {}
data "aws_organizations_organization" "organization" {}

locals {
  non_master_accounts = data.aws_organizations_organization.organization.non_master_accounts
}

locals {
  account_assignments = {
    administrator = {
      permission_set_arn = aws_ssoadmin_permission_set.administrator.arn
      principal_id       = aws_identitystore_group.administrators.group_id
    }
    poweruser = {
      permission_set_arn = aws_ssoadmin_permission_set.poweruser.arn
      principal_id       = aws_identitystore_group.powerusers.group_id
    }
    viewonly = {
      permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn
      principal_id       = aws_identitystore_group.viewonly.group_id
    }
    billing = {
      permission_set_arn = aws_ssoadmin_permission_set.billing.arn
      principal_id       = aws_identitystore_group.billing.group_id
    }
  }
}

resource "aws_ssoadmin_permission_set" "administrator" {
  name             = "Administrator"
  description      = "Administrator access to AWS services"
  instance_arn     = data.aws_ssoadmin_instances.idc.arns[0]
}

resource "aws_ssoadmin_permission_set" "poweruser" {
  name             = "PowerUser"
  description      = "Power user access to AWS services"
  instance_arn     = data.aws_ssoadmin_instances.idc.arns[0]
}

resource "aws_ssoadmin_permission_set" "viewonly" {
  name             = "ViewOnly"
  description      = "View only access to AWS services"
  instance_arn     = data.aws_ssoadmin_instances.idc.arns[0]
}

resource "aws_ssoadmin_permission_set" "billing" {
  name             = "Billing"
  description      = "Billing access to AWS services"
  instance_arn     = data.aws_ssoadmin_instances.idc.arns[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "administrators-administrator-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "administrators-poweruser-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "administrators-viewonly-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "administrators-billing-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_ssoadmin_managed_policy_attachment" "powerusers-poweruser-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.poweruser.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "powerusers-viewonly-policy" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.poweruser.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "viewonly" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "billing" {
  instance_arn = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.billing.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_identitystore_group" "administrators" {
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
  display_name      = "Administrators"
  description       = "Full access to AWS services"
}

resource "aws_identitystore_group" "powerusers" {
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
  display_name      = "PowerUsers"
  description       = "Full access to AWS services (full access minus billing)"
}

resource "aws_identitystore_group" "viewonly" {
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
  display_name      = "ViewOnly"
  description       = "View only access to AWS services"
}

resource "aws_identitystore_group" "billing" {
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
  display_name      = "Billing"
  description       = "Billing access to AWS services"
}

resource "aws_identitystore_user" "admin" {
  name {
    family_name = "Stevens"
    given_name  = "Steve"
  }
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
  user_name         = "admin"
  display_name      = var.admin_display_name
  emails {
    primary = true
    value = var.admin_email
  }
  timezone = var.admin_timezone
  user_type = "admin"
}

resource "aws_identitystore_group_membership" "administrators" {
  group_id = aws_identitystore_group.administrators.group_id
  member_id = aws_identitystore_user.admin.user_id
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
}

resource "aws_identitystore_group_membership" "powerusers" {
  group_id = aws_identitystore_group.powerusers.group_id
  member_id = aws_identitystore_user.admin.user_id
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
}

resource "aws_identitystore_group_membership" "viewonly" {
  group_id = aws_identitystore_group.viewonly.group_id
  member_id = aws_identitystore_user.admin.user_id
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
}

resource "aws_identitystore_group_membership" "billing" {
  group_id = aws_identitystore_group.billing.group_id
  member_id = aws_identitystore_user.admin.user_id
  identity_store_id = data.aws_ssoadmin_instances.idc.identity_store_ids[0]
}

resource "aws_ssoadmin_account_assignment" "master_assignments" {
  for_each          = local.account_assignments
  instance_arn      = data.aws_ssoadmin_instances.idc.arns[0]
  permission_set_arn = each.value.permission_set_arn
  target_id         = data.aws_caller_identity.current.account_id
  principal_id      = each.value.principal_id
  target_type       = "AWS_ACCOUNT"
  principal_type    = "GROUP"
}

resource "aws_ssoadmin_account_assignment" "dev_assignments" {
    for_each          = local.account_assignments
    instance_arn      = data.aws_ssoadmin_instances.idc.arns[0]
    permission_set_arn = each.value.permission_set_arn
    target_id         = aws_organizations_account.dev.id
    principal_id      = each.value.principal_id
    target_type       = "AWS_ACCOUNT"
    principal_type    = "GROUP"
}

resource "aws_ssoadmin_account_assignment" "test_assignments" {
    for_each          = local.account_assignments
    instance_arn      = data.aws_ssoadmin_instances.idc.arns[0]
    permission_set_arn = each.value.permission_set_arn
    target_id         = aws_organizations_account.test.id
    principal_id      = each.value.principal_id
    target_type       = "AWS_ACCOUNT"
    principal_type    = "GROUP"
}

resource "aws_ssoadmin_account_assignment" "qa_assignments" {
    for_each          = local.account_assignments
    instance_arn      = data.aws_ssoadmin_instances.idc.arns[0]
    permission_set_arn = each.value.permission_set_arn
    target_id         = aws_organizations_account.qa.id
    principal_id      = each.value.principal_id
    target_type       = "AWS_ACCOUNT"
    principal_type    = "GROUP"
}

resource "aws_ssoadmin_account_assignment" "prod_assignments" {
    for_each          = local.account_assignments
    instance_arn      = data.aws_ssoadmin_instances.idc.arns[0]
    permission_set_arn = each.value.permission_set_arn
    target_id         = aws_organizations_account.prod.id
    principal_id      = each.value.principal_id
    target_type       = "AWS_ACCOUNT"
    principal_type    = "GROUP"
}