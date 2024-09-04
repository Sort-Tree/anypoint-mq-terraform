prefix = "acme_"
suffix = "_dev"

queues = [
  {
    queue_name    = "orders"
    exchange_name = "order_events"
  },
  {
    queue_name    = "payments"
    exchange_name = "payment_events"
  }
]
