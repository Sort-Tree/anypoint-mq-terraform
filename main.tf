locals {
  exchange_binding = flatten([for indexExchange, valueExchange in var.exchanges : [
    for indexQueue, valueQueue in valueExchange.queues : {
      org_id      = var.org_id
      env_id      = var.env_id
      region_id   = var.region
      exchange_id = "${var.prefix}${valueExchange.exchange_name}${var.suffix}"
      queue_id    = "${var.prefix}${valueQueue}${var.suffix}"
    }
  ]])

}


# Creating DLQs for all queues
resource "anypoint_amq" "dlq" {
  for_each = { for queue in var.queues : queue.queue_name => queue }

  org_id           = var.org_id
  env_id           = var.env_id
  region_id        = var.region
  queue_id         = "${var.prefix}${each.key}-dlq${var.suffix}"
  fifo             = each.value.fifo
  default_ttl      = each.value.default_ttl
  default_lock_ttl = each.value.default_lock_ttl
}

# Creating queues
resource "anypoint_amq" "queue" {
  for_each = { for queue in var.queues : queue.queue_name => queue }

  org_id               = var.org_id
  env_id               = var.env_id
  region_id            = var.region
  queue_id             = "${var.prefix}${each.key}${var.suffix}"
  fifo                 = each.value.fifo
  default_ttl          = each.value.default_ttl
  default_lock_ttl     = each.value.default_lock_ttl
  dead_letter_queue_id = "${var.prefix}${each.key}-dlq${var.suffix}"
  max_deliveries       = each.value.max_deliveries

  depends_on = [
    anypoint_amq.dlq
  ]
}

# Creating exchanges
resource "anypoint_ame" "exchange" {
  for_each = { for exchange in var.exchanges : exchange.exchange_name => exchange }

  exchange_id = "${var.prefix}${each.key}${var.suffix}"
  env_id      = var.env_id
  org_id      = var.org_id
  region_id   = var.region
  encrypted   = each.value.encrypted
}

# Binding queues to exchanges
resource "anypoint_ame_binding" "ame_binding" {

  for_each = { for bindings in local.exchange_binding : bindings.exchange_id => bindings }

  org_id      = each.value.org_id
  env_id      = each.value.env_id
  region_id   = each.value.region_id
  exchange_id = each.value.exchange_id
  queue_id    = each.value.queue_id
}

output "name" {
  value       = local.exchange_binding
  description = "description"
}

