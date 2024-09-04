variable "queues" {
  description = "List of queues and their attributes"
  type        = list(object({
    queue_name = string
    exchange_name = string
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
  default     = "US"
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
