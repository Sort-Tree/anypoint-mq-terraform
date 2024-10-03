terraform {
  required_providers {
    anypoint = {
      source  = "mulesoft-anypoint/anypoint"
      version = "1.7.0"
    }
  }
}

provider "anypoint" {
  client_id     = var.client_id     # optionally use ANYPOINT_CLIENT_ID env var
  client_secret = var.client_secret # optionally use ANYPOINT_CLIENT_SECRET env var

  # You may need to change the anypoint control plane: use 'eu' or 'us'
  # by default the control plane is 'us'
  cplane = var.cplane # optionnaly use ANYPOINT_CPLANE env var
}