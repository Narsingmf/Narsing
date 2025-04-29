# ECS Terraform Module

This repository contains a modular Terraform implementation for deploying an ECS cluster with best practices.

## Architecture

The implementation follows these best practices:

1. **Code Modularity**:
   - Separated into reusable modules (VPC, ECS)
   - Clear separation of concerns
   - Parameterized resources for flexibility

2. **State Management**:
   - Configured for remote state storage with S3 and DynamoDB locking (commented by default)
   - Proper state organization

3. **Infrastructure Components**:
   - VPC with public and private subnets
   - NAT Gateways for private subnet connectivity
   - ECS Fargate cluster
   - Application Load Balancer
   - Auto-scaling configuration
   - Security groups with least privilege
   - IAM roles with appropriate permissions

## Directory Structure

```
.
├── main.tf              # Main configuration file
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── provider.tf          # Provider configuration
└── modules/
    ├── vpc/             # VPC module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecs/             # ECS module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Usage

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Review the execution plan:
   ```
   terraform plan
   ```

3. Apply the configuration:
   ```
   terraform apply
   ```

4. To destroy the resources:
   ```
   terraform destroy
   ```

## Remote State Configuration

To enable remote state storage, uncomment and configure the backend section in `provider.tf`:

```hcl
backend "s3" {
  bucket         = "terraform-state-bucket"
  key            = "ecs/terraform.tfstate"
  region         = "us-west-2"
  dynamodb_table = "terraform-locks"
  encrypt        = true
}
```

## Customization

Modify the variables in `variables.tf` to customize the deployment according to your requirements.