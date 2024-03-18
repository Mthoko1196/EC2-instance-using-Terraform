# EC2 Instance Deployment Using Terraform

This Terraform script enables the deployment of an EC2 instance on AWS with specific configurations. The script ensures that the EC2 instance meets the following requirements:

- Utilizes a T2Micro instance type.
- Allocates 12GB of storage.
- Can be deployed in any AWS region (e.g., London).
- Allows SSH and RDP access from a single IP address.
- Grants access to HTTP from anywhere.

## Infrastructure and Environment

- **Infrastructure Provider**: AWS (Cloud)
- **Deployment Tool**: Terraform
- **Integrated Development Environment (IDE)**: VS Code

## Prerequisites

Before running this Terraform script, ensure the following:

1. **AWS Account**: You must have an AWS account with appropriate permissions to create resources like EC2 instances.
2. **Terraform Installation**: Install Terraform on your local machine. Refer to the [official Terraform documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli) for installation instructions.
3. **AWS CLI Configuration**: Configure AWS CLI on your machine with the necessary credentials. You can set it up by following the [AWS CLI configuration guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

## Usage

1. **Clone Repository**: Clone this repository to your local machine or download the Terraform script.

    ```bash
    git clone https://github.com/yourusername/EC2-instance-using-Terraform.git
    ```

2. **Navigate to Directory**: Change directory to the cloned repository.

    ```bash
    cd EC2-instance-using-Terraform
    ```

3. **Update Variables (Optional)**: Open the `variables.tf` file and update any variables if needed, such as the AWS region, SSH/RDP IP address, etc.

4. **Initialize Terraform**: Run `terraform init` to initialize the working directory containing Terraform configuration files.

    ```bash
    terraform init
    ```

5. **Review Plan**: Execute `terraform plan` to see the execution plan, which will show what actions Terraform will take to create the resources.

    ```bash
    terraform plan
    ```

6. **Apply Changes**: If the plan looks satisfactory, apply the changes by running `terraform apply`. This will create the EC2 instance as per the defined configurations.

    ```bash
    terraform apply
    ```

7. **Access Resources**: Once the deployment is complete, you can access the deployed EC2 instance via SSH or RDP using the specified IP address. Additionally, HTTP access will be available from anywhere.

8. **Destroy Resources (Optional)**: If you wish to tear down the infrastructure and destroy the created resources, run `terraform destroy`.

    ```bash
    terraform destroy
    ```

## Notes

- Ensure that you review and understand the changes that Terraform will make before applying them to your AWS environment.
- Always follow security best practices, such as restricting access only to necessary IP addresses and regularly updating your infrastructure.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
