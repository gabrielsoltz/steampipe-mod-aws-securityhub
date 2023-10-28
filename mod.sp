locals {
  aws_securityhub_common_tags = {
    category = "Security"
    plugin   = "aws"
    service  = "SecurityHub"
  }
}

# The AWS Security Hub Findings Table and Connection (connection.table)
# Example AWS: aws_sh_master.aws_securityhub_finding
# Example Local: public.local_aws_securityhub_finding
variable "sh_findings_connection_table" {
  type = string
  default = "aws_sh_master.aws_securityhub_finding"
}

# The AWS Tagging Table and Connection (connection.table)
# Example AWS: aws.aws_tagging_resource
# Example Local: public.local_aws_tagging_resource
variable "aws_tagging_resources_table" {
  type = string
  default = "aws.aws_tagging_resource"
}

# AWS Security Hub Aggregator Region.
# If you are not aggregating findings from multiple accounts use: "ALL"
variable "sh_aggregator_region" {
  type = string
  default = "eu-west-1"
}

mod "aws_securityhub" {
  title         = "Steampipe Mod for AWS Security Hub"
  description   = "AWS Security Hub Mod"
  color         = "#FF9900"
  documentation = file("./docs/index.md")
  icon          = ""
  categories    = ["aws", "public cloud", "security"]

  opengraph {
    title       = "Steampipe Mod for AWS Security Hub"
    description = "AWS Security Hub Mod"
    image       = ""
  }
}
