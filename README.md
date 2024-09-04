# Terraform Anypoint MQ Provisioning

This repository contains Terraform code to provision queues, exchanges, dead-letter queues (DLQs), and bindings in MuleSoft Anypoint MQ. The configuration is customizable via a `terraform.tfvars` file, allowing users to add prefixes, suffixes, environment configuration, and queue/exchange definitions.

## Features
- **Create Queues:** Define queues with customizable names, prefixes, and suffixes.
- **Create Exchanges:** Create exchanges (topics) to manage message routing.
- **Queue Bindings:** Bind queues to exchanges using a routing key.
- **Dead-Letter Queues (DLQ):** Automatically create a DLQ for each queue.

## Prerequisites
Before you can use this Terraform code, ensure that you have the following:

1. **Terraform**: Install Terraform (v0.12 or later) on your machine.
   - Installation instructions can be found [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
   
2. **MuleSoft Anypoint Account**: You will need credentials to access your MuleSoft Anypoint organization:
   - Username
   - Password
   - Organization ID
   - Environment ID (of the target environment for deployment)

3. **Anypoint MQ Permissions**: Ensure your user account has the necessary permissions to create exchanges, queues, and bindings in the target environment.

## Terraform Configuration

### Variables

The following variables are available for customization in `terraform.tfvars`:

| Variable         | Description                                                     | Type   | Default       |
|------------------|-----------------------------------------------------------------|--------|---------------|
| `queues`         | List of queue and exchange configurations (name and binding).   | List   | `[]`          |
| `prefix`         | Optional prefix for queue names.                                | String | `""`          |
| `suffix`         | Optional suffix for queue names.                                | String | `""`          |
| `environment_id` | MuleSoft environment ID where the resources will be provisioned.| String | N/A           |
| `region`         | Region for Anypoint MQ resources.                               | String | `"us-east-1"` |

### Example `terraform.tfvars`
```hcl
prefix = "app_"
suffix = "_queue"

environment_id = "your-environment-id"

region = "us-east-1"

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
```
## How to Add New Queues and Exchanges
Define each queue and its corresponding exchange in the queues list.
Optionally, add a prefix or suffix to the queue names using the prefix and suffix variables.
Every queue will automatically have a corresponding DLQ created, with the suffix -dlq appended to its name.

## How to Use
Step 1: Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/anypoint-mq-terraform.git
cd anypoint-mq-terraform

Step 2: Set Up Environment Variables
You will need to set your MuleSoft credentials as environment variables:

bash
Copy code
export ANYPOINT_USERNAME="your-username"
export ANYPOINT_PASSWORD="your-password"
export ANYPOINT_ORG_ID="your-org-id"
Step 3: Modify terraform.tfvars
Update the terraform.tfvars file with your queue, exchange, and environment details.

Step 4: Initialize Terraform
Run the following command to initialize the Terraform environment:

bash
Copy code
terraform init
Step 5: Apply the Terraform Configuration
To create the resources in Anypoint MQ, run:

bash
Copy code
terraform apply
Confirm the operation by typing yes when prompted.

Step 6: Verify
Once the Terraform run is complete, you can verify the resources (queues, exchanges, and bindings) in the MuleSoft Anypoint MQ console.

## Cleanup
To delete the resources created by this Terraform configuration, run the following command:

bash
Copy code
terraform destroy
Confirm the destruction by typing yes when prompted.

## Troubleshooting
Authentication Errors: Make sure the correct MuleSoft credentials (username, password, organization ID) are exported as environment variables.
Permission Issues: Ensure you have the required permissions to create Anypoint MQ resources (queues, exchanges, bindings) in your target environment.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.