## 🛑 Three ways to destroy resources in Terraform
1. **Using `terraform destroy`**: This command will destroy all the resources defined in your Terraform configuration. It is the most straightforward way to clean up all resources managed by Terraform.
2. **Using commented-out code**: If you comment out the resource definitions in your Terraform configuration files, the next time you run `terraform apply`, Terraform will not manage those resources anymore. However, this does not delete them; it simply stops managing them.
3. **Delete the code**: You can manually delete the resource definitions from your Terraform configuration files. The next time you run `terraform apply`, Terraform will detect that the resources are no longer defined and will destroy them.

## 🎯 Terraform destroy specific resources
To destroy specific resources in Terraform, you can use the `-target` option with the `terraform destroy` command. This allows you to specify which resources you want to destroy without affecting the others.

For example, to destroy a specific AWS instance, you can run:
```
terraform destroy -target=aws_instance.myec2
```

## 📄 Terraform tfstate file purpose
The `terraform.tfstate` file is crucial for Terraform's operation. It keeps track of the current state of your infrastructure. This file contains information about the resources that Terraform manages, including their IDs, attributes, and relationships. When you run `terraform apply`, Terraform compares the desired state defined in your configuration files with the current state in the `terraform.tfstate` file to determine what changes need to be made.
If the `terraform.tfstate` file is lost or corrupted, Terraform will not be able to accurately determine the current state of your infrastructure, which can lead to issues when applying changes or destroying resources. Therefore, it is essential to back up this file regularly, especially in production environments.

## 🚫 Do not touch the tfstate file
It is important not to manually edit the `terraform.tfstate` file. Doing so can lead to inconsistencies between the actual state of your infrastructure and what Terraform believes the state to be. This can cause unexpected behavior, such as resources not being created, updated, or destroyed as intended. Always use Terraform commands to manage your infrastructure and let Terraform handle the state file automatically.

## ❌ Do not delete the tfstate file
Deleting the `terraform.tfstate` file is highly discouraged. If you delete this file, Terraform will lose track of all the resources it manages. This means that Terraform will not know what resources exist in your infrastructure, and running `terraform apply` will attempt to create all resources from scratch, potentially leading to duplicate resources or conflicts. If you need to reset your Terraform state, consider using `terraform state rm` to remove specific resources or `terraform init -reconfigure` to reinitialize your Terraform environment without losing the state file.  

## Terraform tries to ensure the deployed infastructure matches the desired state
Terraform operates on the principle of declarative infrastructure management. This means that you define the desired state of your infrastructure in configuration files, and Terraform takes care of making that state a reality. When you run `terraform apply`, Terraform compares the current state of your infrastructure (as recorded in the `terraform.tfstate` file) with the desired state defined in your configuration files. It then calculates the necessary changes to bring the current state in line with the desired state. This may involve creating new resources, updating existing ones, or destroying resources that are no longer needed. Terraform's goal is to ensure that the actual infrastructure matches the desired state as closely as possible, while also managing dependencies and relationships between resources.

## If the EC2 instance is configured with Terraform, for example t2.nano, and it is manually changed to t2.micro, Terraform will not change it back to t2.nano
When you manually change a resource that is managed by Terraform, such as changing the instance type of an EC2 instance from `t2.nano` to `t2.micro`, Terraform will not automatically revert that change back to `t2.nano` during the next `terraform apply`. This is because Terraform only manages the state of resources as defined in your configuration files. If the configuration files still specify `t2.nano`, Terraform will not detect the manual change and will not attempt to revert it. That will cause the EC2 stop and start, which may lead to data loss or downtime if the instance is not configured to handle such changes gracefully. To ensure that Terraform manages the resource correctly, you should always make changes through Terraform configuration files and apply them using `terraform apply`. If you need to update the instance type, modify the configuration file accordingly and then run `terraform apply` to bring the actual state in line with the desired state.

## If the resource has some configuration that is not defined in the Terraform code, and if that missing configuration is changed manually, Terraform will not change it back to the original value
Terraform only manages the attributes and configurations that are explicitly defined in your Terraform configuration files. If a resource has some configuration that is not defined in the Terraform code, and you manually change that configuration, Terraform will not revert it back to the original value during the next `terraform apply`. This is because Terraform does not have visibility into or control over attributes that are not specified in the configuration files. As a result, any manual changes made to those attributes will persist, and Terraform will not attempt to modify them unless they are explicitly defined in the configuration. To ensure that all configurations are managed by Terraform, it is essential to include all relevant attributes in your Terraform code. If you need to change a configuration that is not currently defined in your Terraform files, you should update the configuration files accordingly and then run `terraform apply` to apply the changes. This way, Terraform will have a complete understanding of the desired state of the resource and can manage it effectively going forward.  

## Always sepecify the provider version
When working with Terraform, it is crucial to specify the provider version in your configuration files. This ensures that you are using a specific version of the provider that is compatible with your Terraform code and infrastructure. By specifying the provider version, you can avoid unexpected changes or breaking changes that may occur in newer versions of the provider.
To specify the provider version, you can use the `required_providers` block in your Terraform configuration file. For example:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
```
In this example, the AWS provider is specified with a version constraint of `~> 3.0`, which means that any version from `3.0.0` up to, but not including, `4.0.0` will be used. This helps ensure that your Terraform code remains stable and predictable, even as new versions of the provider are released.
By always specifying the provider version, you can maintain consistency across different environments and avoid potential issues that may arise from using incompatible provider versions. It is a best practice to regularly review and update your provider versions to take advantage of new features, bug fixes, and security updates while ensuring compatibility with your existing Terraform code. 

## Use `terraform init -upgrade` to update provider versions
To update the provider versions in your Terraform configuration, you can use the `terraform init -upgrade` command. This command will reinitialize your Terraform working directory and upgrade the provider versions to the latest compatible versions based on the version constraints specified in your configuration files.
For example, if you have specified a provider version constraint in your `required_providers` block, running `terraform init -upgrade` will check for the latest versions of the providers that match those constraints and download them if necessary. This ensures that you are using the most up-to-date versions of the providers while still adhering to the version constraints you have defined.
Here’s how you can use the command:
```bash
terraform init -upgrade
```
This command will:
1. Reinitialize the Terraform working directory.
2. Check for the latest versions of the providers specified in your configuration files.
3. Download and install the latest compatible versions of the providers.
4. Update the `.terraform.lock.hcl` file with the new provider versions.
By using `terraform init -upgrade`, you can ensure that your Terraform environment is using the latest provider versions while maintaining compatibility with your existing configuration. This is particularly useful when you want to take advantage of new features, bug fixes, or security updates provided by the Terraform providers without having to manually update the version constraints in your configuration files.
It is a good practice to run this command periodically, especially before applying changes to your infrastructure, to ensure that you are using the most recent and stable versions of the providers.   

## Don't run `terraform refresh` manually. It can remove your tfstate content entirely
The `terraform refresh` command is used to update the Terraform state file (`terraform.tfstate`) with the current state of the infrastructure. However, it is important to note that running `terraform refresh` manually can lead to unintended consequences, including the potential removal of content from your state file.
When  you run `terraform refresh`, Terraform will query the actual state of the resources in your infrastructure and update the state file accordingly. If there are discrepancies between the state file and the actual resources, it may result in Terraform removing entries from the state file that it believes no longer exist or are not managed by Terraform. This can lead to a situation where Terraform loses track of resources that it was previously managing, which can cause issues when you try to apply changes or destroy resources in the future.
Therefore, it is generally recommended to avoid running `terraform refresh` manually unless you have a specific reason to do so and fully understand the implications. Instead, you should rely on Terraform commands like `terraform apply` or `terraform plan`, which will automatically handle state updates and ensure that your infrastructure remains consistent with your configuration files.
If you need to refresh the state file, consider using `terraform apply` or `terraform plan` to ensure that any changes are applied correctly and that the state file is updated in a controlled manner. If you find yourself needing to refresh the state file frequently, it may indicate that there are issues with your Terraform configuration or the way resources are being managed. In such cases, it is advisable to review your configuration and ensure that all resources are properly defined and managed by Terraform.
If you do encounter issues with your state file or need to recover from a situation where content has been removed, you can restore from a backup of the `terraform.tfstate` file if you have one. Regularly backing up your state file is a best practice to prevent data loss and ensure that you can recover from unexpected changes or issues.  

## Do not include secret key in the Terraform provider configuration
When configuring providers in Terraform, it is crucial to avoid hardcoding sensitive information such as secret keys directly in your configuration files. Instead, you should use environment variables or secure storage solutions to manage sensitive data. This helps prevent accidental exposure of sensitive information and enhances the security of your infrastructure.
For example, instead of including a secret key directly in your provider configuration, you can use an environment variable to store the secret key securely. Here’s how you can do it:
```hcl
provider "aws" {
  region     = "ap-southeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```
In this example, the `aws_access_key` and `aws_secret_key` variables can be defined in a separate `variables.tf` file or passed as environment variables when running Terraform commands. This way, you can keep your sensitive information out of your configuration files and reduce the risk of accidental exposure.
To set environment variables, you can use the following commands in your terminal:
```bash
export TF_VAR_aws_access_key="your_access_key"
export TF_VAR_aws_secret_key="your_secret_key"
```
By using environment variables, you can keep your sensitive information secure while still allowing Terraform to access it when needed. This approach also makes it easier to manage different environments (e.g., development, staging, production) without hardcoding sensitive values in your configuration files.
Additionally, consider using tools like HashiCorp Vault or AWS Secrets Manager to securely store and manage sensitive information. These tools provide a more robust solution for managing secrets and can integrate with Terraform to retrieve sensitive data at runtime without exposing it in your configuration files.
In summary, always avoid including secret keys or other sensitive information directly in your Terraform configuration files. Instead, use environment variables or secure storage solutions to manage sensitive data securely. This practice helps protect your infrastructure and reduces the risk of accidental exposure of sensitive information.   