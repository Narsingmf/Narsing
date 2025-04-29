# Node.js Application with ECS Terraform Infrastructure

This repository contains a Node.js application with a CI/CD pipeline for deployment to AWS ECS using Terraform infrastructure.

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

4. **CI/CD Pipeline**:
   - GitHub Actions workflow for automated builds, tests, and deployments
   - Multi-environment support (dev, staging, prod)
   - Docker container building and publishing to ECR
   - Automated ECS deployment

## Directory Structure

```
.
├── .github/
│   └── workflows/
│       └── nodejs-cicd.yml    # CI/CD pipeline configuration
├── src/                       # Node.js application source code
│   ├── index.js               # Main application file
│   └── __tests__/             # Test files
│       └── index.test.js      # Test for index.js
├── main.tf                    # Main Terraform configuration file
├── variables.tf               # Terraform input variables
├── outputs.tf                 # Terraform output values
├── provider.tf                # Terraform provider configuration
├── pipeline.tf                # Terraform pipeline configuration
├── Dockerfile                 # Docker configuration for the application
├── package.json               # Node.js package configuration
└── modules/                   # Terraform modules
    ├── vpc/                   # VPC module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecs/                   # ECS module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Usage

### Local Development

1. Install dependencies:
   ```
   npm install
   ```

2. Run the application in development mode:
   ```
   npm run dev
   ```

3. Run tests:
   ```
   npm test
   ```

4. Build the application:
   ```
   npm run build
   ```

### Docker

1. Build the Docker image:
   ```
   docker build -t nodejs-app .
   ```

2. Run the Docker container:
   ```
   docker run -p 3000:3000 nodejs-app
   ```

### Infrastructure Deployment

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

### CI/CD Pipeline

The CI/CD pipeline is configured using GitHub Actions and is defined in `.github/workflows/nodejs-cicd.yml`. The pipeline will automatically:

1. Build and test the Node.js application
2. Build and push a Docker image to Amazon ECR
3. Deploy the application to Amazon ECS

#### Required Secrets

Add the following secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key with permissions to ECR and ECS
- `AWS_SECRET_ACCESS_KEY`: AWS secret key

#### Environment Variables

The following environment variables can be configured in GitHub repository variables:

- `AWS_REGION`: AWS region (default: us-west-2)
- `ECR_REPOSITORY`: ECR repository name
- `ECS_CLUSTER`: ECS cluster name
- `ECS_SERVICE`: ECS service name
- `ECS_TASK_DEFINITION`: ECS task definition name
- `CONTAINER_NAME`: Container name in the task definition

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