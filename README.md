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
└── README.md
```

---

## 🚀 How to Run

**Step 1:** Initialize Terraform

```
terraform init
```

**Step 2:** Validate configuration

```
terraform validate
```

**Step 3:** Preview execution plan

```
terraform plan
```

**Step 4:** Apply infrastructure

```
terraform apply
```

```
terraform apply -auto-approve
```

---

## 🌍 Access the Application

After successful deployment, Terraform will output something like:

```
Outputs:

app_url = "http://100.30.231.33"
public_ip = "100.30.231.33"
```

Open your browser and visit `app_url`:

(give few mins before accessing the url)

```
http://100.30.231.33
```

You should see:

```
Hello from Python Flask App! 🚀

```

---

## 🧹 Destroy Infrastructure

To avoid AWS charges, always destroy resources when not needed:

```
terraform destroy
```

```
terraform destroy -auto-approve
```

---

## 🧠 What This Project Demonstrates

This project shows practical understanding of:

- **Infrastructure as Code (Terraform)**
  - Provisioned AWS infrastructure using Terraform
  - Defined repeatable and version-controlled infrastructure setup
  - Built modular components for consistent deployments
  - Externalized configuration such as AWS region and instance type in `variables.tf`
  - Exposed key deployment details such as EC2 public IP and application URL via `outputs.tf`
- **AWS EC2 provisioning**
  - Launched Amazon Linux 2 EC2 instances using dynamic AMI lookup
  - Configured instance to run a public web application
  - Enabled public IP access for external connectivity
- **Security Groups and basic networking**
  - Configured inbound rules for HTTP (80) and SSH (22)
  - Implemented VPC-based networking with custom subnets
  - Set up Internet Gateway and route tables for public access
- **Automated server bootstrapping using user_data**
  - Automated installation of Python and Flask at launch
  - Deployed application files during instance initialization
  - Configured service startup using shell scripting
- **Deploying a working web application in the cloud (AWS)**
  - Hosted a Flask web application on AWS EC2
  - Served dynamic HTML displaying real-time server-generated timestamp over a public endpoint

---

## 💻 Author

[Vinay Singh](https://vinay-singh-engineer.github.io/portfolio)

---

## 📌 Notes

- Ensure AWS credentials are configured properly before running Terraform
- This project is intended for learning and demonstration purposes
- Always run terraform destroy to avoid unnecessary AWS costs

---