# DevOps Test for Endava Interns 🚀

This repository contains a Terraform project designed to deploy a serverless architecture on AWS, demonstrating a practical DevOps test for Endava interns. The project showcases how to build an infrastructure with high availability and security, following the principle of least possible permission.

## 🌐 Overview

In the realm of cloud computing and DevOps, mastering Infrastructure as Code (IaC) is crucial. This project leverages Terraform 🛠️ to provision and manage AWS resources efficiently, ensuring that the infrastructure setup is repeatable, scalable, and transparent.

### 💡 Project Goals

- **High Availability:** Ensure that the infrastructure can withstand failures and continue to operate.
- **Security:** Implement security best practices to minimize vulnerabilities and unauthorized access.
- **Serverless Architecture:** Utilize AWS services to create a serverless setup that is easy to manage and scale.

## 🛠️ Technology Stack

- **Terraform:** Used for provisioning and managing AWS resources as code.
- **AWS Lambda:** Runs the application code in response to triggers such as HTTP requests via API Gateway.
- **Amazon API Gateway:** Serves as the entry point for the application, routing traffic to the appropriate Lambda function.
- **Amazon S3:** Hosts a static file (`text.txt`) and serves as the storage solution.
- **Amazon VPC:** Configures the network to ensure secure and isolated cloud resources.

## 📚 Documentation

This README provides a comprehensive guide on how to deploy and test the infrastructure. For detailed instructions and explanations of the Terraform configurations, refer to the individual `.tf` files within this repository.

### 📖 Index

- [🏗️ Solution Architecture](#solution-architecture)
  - [🔄 Solution Flow](#solution-flow)
- [⚙️ Terraform Configuration](#terraform-configuration)
- [🚀 Provisioning and Deployment](#provisioning-and-deployment)
  - [🔑 Prerequisites](#prerequisites)
  - [🛠️ Deployment Steps](#deployment-steps)
- [🧪 Testing the Infrastructure](#testing-the-infrastructure)

---

## 🏗️ Solution Architecture

The infrastructure is designed with a serverless architecture in mind, focusing on scalability, reliability, and security.

### 🔄 Solution Flow

1. **API Gateway:** Acts as the entry point, routing traffic to the Lambda function.
2. **Lambda Function:** Executes the application logic, fetching content from the S3 bucket.
3. **S3 Bucket:** Stores the `text.txt` file, which contains the string "Hello World."

## ⚙️ Terraform Configuration

The Terraform setup is divided into several files for clarity and maintainability:

- `vpc.tf`: Configures the VPC with subnets, NAT Gateways, and route tables for network isolation.
- `lambda.tf`: Defines the AWS Lambda function and its permissions.
- `apigw.tf`: Sets up the API Gateway resources and integrates them with the Lambda function.
- `bucket.tf`: Provisions the S3 bucket and uploads the `text.txt` file.
- `iamrole.tf`: Creates IAM roles and policies for secure access to AWS services.

## 🚀 Provisioning and Deployment

### 🔑 Prerequisites

- AWS Account
- Terraform installed
- AWS CLI configured

### 🛠️ Deployment Steps

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

## 🧪 Testing the Infrastructure

After successfully deploying your infrastructure, you can test its functionality by accessing the API Gateway URL. This URL acts as the entry point for your serverless application.

**Access the API Gateway URL:**
    The API Gateway URL is output by Terraform upon successful deployment. Look for an output variable named something like api_gateway_invoke_url in the terminal.
    Copy this URL.
    
  Test the Lambda Function:
  
  Paste the API Gateway URL into your web browser or use a tool like curl to make a request to the URL.
        If everything is configured correctly, the Lambda function will be triggered and fetch the content of text.txt from the S3 bucket.
  ### Example curl command:  
    curl -X GET <api_gateway_invoke_url>
You should receive a response containing the content of the text.txt file, which demonstrates that the infrastructure is working as expected.

Congratulations! 🎉 You have successfully deployed and tested your serverless architecture using Terraform on AWS.
