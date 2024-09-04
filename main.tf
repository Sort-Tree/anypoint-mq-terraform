provider "anypoint" {
  client_id = var.client_id             # optionally use ANYPOINT_CLIENT_ID env var
  client_secret = var.client_secret     # optionally use ANYPOINT_CLIENT_SECRET env var

  # You may need to change the anypoint control plane: use 'eu' or 'us'
  # by default the control plane is 'us'
  cplane= var.cplane                    # optionnaly use ANYPOINT_CPLANE env var
}

# Creating exchanges
resource "anypoint_ame" "exchange" {
  for_each = { for exchange in var.queues : exchange.exchange_name => exchange }

  exchange_id       = each.key
  region     = var.region
  env_id     = var.environment_id
  org_id     = var.org_id
  region_id = var.region
  encrypted = true
}

# Creating queues
resource "anypoint_amq" "queue" {
  for_each = { for queue in var.queues : queue.queue_name => queue }

  name         = "${var.prefix}${each.key}${var.suffix}"
  region       = var.region
  environment_id = var.environment_id

  org_id = var.org_id
  env_id = var.env_id
  region_id = var.region
  queue_id = "${var.prefix}${each.key}${var.suffix}"
  fifo = false
  default_ttl = 604800000
  default_lock_ttl = 120000
  dead_letter_queue_id = "${var.prefix}${each.key}-dlq${var.suffix}"
  max_deliveries = 10

}

# Binding queues to exchanges
resource "anypoint_ame_binding" "binding" {
  for_each = { for queue in var.queues : queue.queue_name => queue }

  org_id = var.org_id
  env_id = var.env_id
  region_id = var.region
  exchange_id = anypoint_ame.exchange[each.value.exchange_name].id
  queue_id = anypoint_amq.queue[each.key].id
}
