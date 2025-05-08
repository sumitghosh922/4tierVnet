locals {
  owner = var.business_divsion
  environment = var.environment
  resource_prefix = "${var.business_divsion}-${var.environment}"

  common_tags = {
    owner = locals.owner
    env = locals.environment
  }
}