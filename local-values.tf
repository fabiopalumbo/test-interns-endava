locals {
    name                  = "${var.prefix}-${var.environment}"
    common_tags = {
        name        = local.name
    }
}