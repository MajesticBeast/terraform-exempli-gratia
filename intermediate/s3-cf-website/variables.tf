variable "account_num" {
    description = "The AWS account number"
    type        = string
}

variable "assume_role_name" {
    description = "The name of the role to assume"
    type        = string
}

variable "region" {
    description = "The AWS region"
    type        = string
}

variable "bucket_name_prefix" {
    description = "The prefix to use for the bucket name"
    type        = string
}

variable "default_root_object" {
    description = "The default root object to serve"
    type        = string
    default     = "index.html"
}

variable "allowed_methods" {
    description = "The allowed methods for the CloudFront distribution"
    type        = list(string)
    default     = ["GET", "HEAD"]
}

variable "cached_methods" {
    description = "The cached methods for the CloudFront distribution"
    type        = list(string)
    default     = ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
    description = "The viewer protocol policy for the CloudFront distribution"
    type        = string
    default     = "redirect-to-https"
}

variable "geo_restriction_type" {
    description = "The geo restriction type for the CloudFront distribution"
    type        = string
    default     = "none"
}

variable "tag_name" {
    description = "The name tag for the CloudFront distribution"
    type        = string
}

variable "cache_policy_name" {
    description = "The name of the cache policy"
    type        = string
    default     = "default"
}

variable "policy_comment" {
    description = "The description for the cache policy"
    type        = string
    default     = "Managed by Terraform"
}

variable "cookie_behavior" {
    description = "The cookie behavior for the cache policy"
    type        = string
    default     = "none"
}

variable "header_behavior" {
    description = "The header behavior for the cache policy"
    type        = string
    default     = "none"
}

variable "query_string_behavior" {
    description = "The query string behavior for the cache policy"
    type        = string
    default     = "none"
}

variable "oac_name" {
    description = "The name of the origin access control"
    type        = string
}

variable "oac_description" {
    description = "The description of the origin access control"
    type        = string
    default     = "Managed by Terraform"
}

variable "oac_origin_type" {
    description = "The origin type of the origin access control"
    type        = string
    default     = "s3"
}

variable "oac_signing_behavior" {
    description = "The signing behavior of the origin access control"
    type        = string
    default     = "always"
}