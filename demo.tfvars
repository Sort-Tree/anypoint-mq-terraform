prefix        = "acme-"
suffix        = "-dev"
client_id     = "add-here"
client_secret = "add-here"
cplane        = "eu"
org_id        = "add-here"
env_id        = "add-here"
region        = "eu-central-1"


queues = [
  {
    queue_name       = "orders"
    fifo             = false
    default_ttl      = 604800000
    default_lock_ttl = 120000
    max_deliveries   = 10
  },
  {
    queue_name       = "payments"
    fifo             = false
    default_ttl      = 604800000
    default_lock_ttl = 120000
    max_deliveries   = 10
  }
]

exchanges = [
  {
    exchange_name = "simple"
    encrypted     = false
    queues = [
      "payments"
    ]
  }
]
