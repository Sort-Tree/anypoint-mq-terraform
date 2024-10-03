variable "queues" {
  description = "List of queues and their attributes"
  type = list(object({
    queue_name       = string
    fifo             = bool
    default_ttl      = number
    default_lock_ttl = number
    max_deliveries   = number
  }))
  default = []
}

variable "exchanges" {
  description = "List of exchanges"
  type = list(object({
    exchange_name = string
    encrypted     = bool
    queues        = list(string)
  }))
  default = []
}

variable "prefix" {
  description = "Prefix to add to queue names"
  type        = string
  default     = ""
}

variable "suffix" {
  description = "Suffix to add to queue names"
  type        = string
  default     = ""
}

variable "env_id" {
  description = "Environment ID"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "Connected App Client Secret"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "Connected App Client ID"
  type        = string
  default     = ""
}

variable "cplane" {
  description = "Control Plane"
  type        = string
  default     = "us"
}

variable "org_id" {
  description = "Anypoint Platform Org ID"
  type        = string
  default     = ""
}

variable "region" {
  description = "Queue region"
  type        = string
  default     = ""
}
