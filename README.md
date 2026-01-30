# Terraform EC2 AMI Creation

This repository contains Terraform code to automate the creation of a custom Amazon Machine Image (AMI). The process involves launching a base EC2 instance, provisioning it with Docker, and then creating a new AMI from that configured instance. Finally, it launches a new instance from the custom AMI to verify its usability.

## Workflow

1.  **VPC Data Retrieval**: Fetches information about a pre-existing VPC, public subnet, and security group using `data` sources.
2.  **Base EC2 Instance**: Provisions a new EC2 instance (`BaseEC2Instance`) in the public subnet.
3.  **Provisioning**: Connects to the base instance via SSH and uses a `remote-exec` provisioner to update the system and install Docker.
4.  **AMI Creation**: Creates a new custom AMI (`abyss-ami`) from the provisioned base instance.
5.  **Task Instance Launch**: Launches a new EC2 instance (`TaskInstance`) using the newly created custom AMI.

## Project Structure

The repository is organized into Terraform modules for better separation of concerns:

-   `Main.tf`: The root module that defines the workflow and orchestrates the child modules.
-   `/modules/vpc`: Fetches data for the network components (VPC, Subnet, Security Group).
-   `/modules/ec2`: Manages the creation and provisioning of the base EC2 instance.
-   `/modules/ami`: Manages the creation of the AMI from the base instance and launches a final "task" instance.

## Prerequisites

Before you begin, ensure you have the following set up:

*   **Terraform**: [Terraform](https://developer.hashicorp.com/terraform/downloads) installed on your local machine.
*   **AWS Account**: An AWS account with credentials configured for Terraform.
*   **Existing AWS Resources**:
    *   A VPC with the tag `Name` set to `abyss`.
    *   A public subnet within that VPC with the tag `Name` set to `abyss-pub`.
    *   A security group within that VPC with the tag `Name` set to `abyss-wizard`. This security group must allow inbound SSH traffic (port 22) from your IP.
*   **SSH Key Pair**:
    *   An EC2 key pair named `abyss` must exist in your target AWS region.
    *   The corresponding private key file, `abyss.pem`, must be placed in the root directory of this project.

## How to Use

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/Kalam-shadow/tf-ec2-ami.git
    cd tf-ec2-ami
    ```

2.  **Add your private key:**
    Place your `abyss.pem` private key file in the root of the project directory.

3.  **Update AMI ID:**
    In `Main.tf`, update the `ami_id` variable with a valid Amazon Linux 2 AMI ID for your target AWS Region.
    ```hcl
    # Main.tf

    module "EC2" {
        source = "./modules/ec2"
        ami_id = "ami-0ff5003538b60d5ec"  # <-- CHANGE THIS TO A VALID AMI FOR YOUR REGION
        # ...
    }
    ```

4.  **Initialize Terraform:**
    This command will download the necessary providers.
    ```sh
    terraform init
    ```

5.  **Plan the deployment:**
    Review the changes that Terraform will make.
    ```sh
    terraform plan
    ```

6.  **Apply the configuration:**
    This will create the EC2 instance, provision it, create the AMI, and launch the final instance.
    ```sh
    terraform apply
    ```
    Enter `yes` when prompted to confirm.

## Module Details

### `vpc` Module
-   Uses `data` sources `aws_vpc`, `aws_subnet`, and `aws_security_group` to look up existing network resources based on predefined tags.
-   It does **not** create any new networking resources.
-   Outputs the IDs of the subnet and security group for other modules to use.

### `ec2` Module
-   **`ec2.tf`**: Defines an `aws_instance` resource named `base_ec2`.
-   **`provisioner "remote-exec"`**: After the instance is created, this provisioner connects via SSH using the provided `.pem` key to install Docker.
-   **`output.tf`**: Outputs the ID of the `base_ec2` instance.

### `ami` Module
-   **`ami.tf`**: Defines an `aws_ami_from_instance` resource that creates a new AMI from the `base_ec2` instance. The AMI is named with a timestamp to ensure uniqueness.
-   **`task.tf`**: Defines an `aws_instance` resource named `task_instance` that uses the newly created AMI, demonstrating its functionality.
