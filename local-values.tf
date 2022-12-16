locals {
    name                  = "${var.prefix}-${var.business}"
    environment           = var.environment
    common_tags = {
        name        = local.name
        environment = local.environment
    }
}