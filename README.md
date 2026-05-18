# Infrastructure as Code (IaC) with Terraform: Python Web App on AWS 🚀

This project uses **Terraform** to provision AWS infrastructure that runs a simple Python Flask web application.

---

## 🧭 Architecture

Terraform provisions the following on AWS:

- EC2 instance (Amazon Linux 2)
- Security Group (allows HTTP + SSH)
- Flask application using user_data script

### Flow

```
Terraform
  ↓
Custom VPC
  ↓
Public Subnet
  ↓
Internet Gateway
  ↓
Route Table
  ↓
Security Group
  ↓
 EC2
  ↓
Flask App Running
  ↓
Public IP → Browser
```

---

## ⚙️ Prerequisites

Before running this project, install and configure the following tools.

---

### 1. Install Terraform

Download Terraform from: https://developer.hashicorp.com/terraform/downloads

Verify installation: `terraform -v`

### 2. Install AWS CLI

Download AWS CLI from https://aws.amazon.com/cli/

Verify installation: `aws --version`

### 3. Configure AWS credentials

Run: `aws configure`

Enter:

- AWS Access Key ID
- AWS Secret Access Key
- Default region: us-east-1
- Output format: json

---

## 📁 Project Structure

```
iac-python-webapp/
├── main.tf
├── variables.tf
├── outputs.tf
├── user_data.sh
├── index.html
└── README.md
```

---

## 🚀 How to Run

Step 1: Initialize Terraform

```
terraform init
```

Step 2: Validate configuration

```
terraform validate
```

Step 3: Preview execution plan

```
terraform plan
```

Step 4: Apply infrastructure

```
terraform apply
```

---

## 🌍 Access the Application

After successful deployment, Terraform will output something like:

```
public_ip = 3.xx.xx.xx
```

Open your browser and visit:

```
http://<public_ip>
```

You should see:

```
Hello Python 🚀 from Terraform
```

---

## 🧹 Destroy Infrastructure

To avoid AWS charges, always destroy resources when not needed:

```
terraform destroy
```

---

## 🧠 What This Project Demonstrates

This project shows practical understanding of:

- Infrastructure as Code (Terraform)
	- AWS EC2 provisioning
	- Security Groups and basic networking
	- Automated server bootstrapping using user_data
	- Deploying a working web application in the cloud

---

## 💻 Author

Vinay Singh
GitHub: https://github.com/vinay-singh-engineer

---

## 📌 Notes

- Ensure AWS credentials are configured properly before running Terraform
- This project is intended for learning and demonstration purposes
- Always run terraform destroy to avoid unnecessary AWS costs

---