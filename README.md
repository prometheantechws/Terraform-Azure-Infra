# Terraform Azure Infrastructure

This repository contains Terraform modules for setting up a private Azure infrastructure. The modules include resources such as Resource Groups, Virtual Networks, VNet Peering, Private AKS, Azure Container Registry (ACR), Private Endpoints, Private DNS Zones, Key Vault, Virtual Machines, and Storage Accounts.

## Modules

This repository includes the following Terraform modules:

- **Resource Group (RG)**
- **Virtual Network (VNet)**
- **VNet Peering**
- **Private AKS Cluster**
- **Azure Container Registry (ACR)**
- **Private Endpoints**
- **Private DNS Zone**
- **Key Vault**
- **Virtual Machines (Linux and Windows)**
- **Storage Account**

## Getting Started

To get started, clone this repository and make the necessary changes to the `tf.vars` and `main.tf` files.

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- An Azure account with the necessary permissions

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/prometheantechws/Terraform-Azure-Infra.git
    cd Terraform-Azure-Infra
    ```

2. Update the `tf.vars` file with your specific configurations.

3. Make any necessary changes to the `main.tf` file.

4. Once you have updated the configuration files with your details, run the following commands to deploy the infrastructure:

    ```sh
    terraform init
    terraform validate
    terraform plan
    terraform apply
    ```

Terraform will show you a plan of the resources it will create. Review the plan carefully and then apply it to create the resources.

If you have any questions or feedback, reach out us on [LinkedIn](https://www.linkedin.com/company/prometheantech/mycompany/) or [contact@prometheantech.in](mailto:contact@prometheantech.in) .