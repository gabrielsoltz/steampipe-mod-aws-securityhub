locals {
  aws_securityhub_common_tags = {
    category = "Security"
    plugin   = "aws"
    service  = "SecurityHub"
  }
}

mod "aws_securityhub" {
  # hub metadata
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
