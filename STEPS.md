# Advanced End-to-End DevSecOps Kubernetes Three-Tier Project

## Table of Contents

1. [Step 1: IAM User Setup](#step-1-iam-user-setup)
2. [Step 2: Install Terraform & AWS CLI](#step-2-install-terraform--aws-cli)
3. [Step 3: Jenkins Server Configuration](#step-3-jenkins-server-configuration)
4. [Step 4: EKS Cluster Deployment](#step-4-eks-cluster-deployment)
5. [Step 5: Load Balancer Configuration](#step-5-load-balancer-configuration)
6. [Step 6: Amazon ECR Repositories](#step-6-amazon-ecr-repositories)
7. [Step 7: ArgoCD Installation](#step-7-argocd-installation)
8. [Step 8: SonarQube Integration](#step-8-sonarqube-integration)
9. [Step 9: Jenkins Pipelines](#step-9-jenkins-pipelines)
10. [Step 10: Monitoring Setup](#step-10-monitoring-setup)
11. [Step 11: ArgoCD Application Deployment](#step-11-argocd-application-deployment)
12. [Step 12: DNS Configuration](#step-12-dns-configuration)
13. [Step 13: Data Persistence](#step-13-data-persistence)
14. [Step 14: Conclusion and Monitoring](#step-14-conclusion-and-monitoring)

---

## Step 1: IAM User Setup

Create an IAM user on AWS with the necessary permissions to facilitate deployment and management activities.

## Step 2: Install Terraform & AWS CLI

Install Terraform and the AWS CLI on your local machine or server where you'll run the configuration.

## Step 3: Jenkins Server Configuration

Set up a Jenkins server on an AWS EC2 instance, and install essential tools like Docker, SonarQube, Terraform, kubectl, AWS CLI, and Trivy.

- Navigate to the Jenkins-Server-TF
- Do some modifications to the backend.tf file such as changing the bucket name and dynamodb table(make sure you have created both manually on AWS Cloud).
- Replace the Pem File name as you have some other name for your Pem file. To provide the Pem file name that is already created on AWS

## Step 4: EKS Cluster Deployment

Use `eksctl` to create an Amazon EKS cluster in the `us-east-1` region, specifying the node type and the minimum and maximum number of nodes.

## Step 5: Load Balancer Configuration

Configure an AWS Application Load Balancer (ALB) to balance traffic across the EKS cluster, ensuring scalability and availability.

## Step 6: Amazon ECR Repositories

Create private repositories on Amazon Elastic Container Registry (ECR) for storing Docker images for the frontend and backend components.

## Step 7: ArgoCD Installation

Install and set up ArgoCD for continuous delivery (GitOps) to manage application deployments to the EKS cluster.

## Step 8: SonarQube Integration

Integrate SonarQube into the DevSecOps pipeline for code quality and security analysis, enhancing application reliability and security.

## Step 9: Jenkins Pipelines

Develop Jenkins pipelines to automate the deployment of the backend and frontend applications to the EKS cluster.

## Step 10: Monitoring Setup

Implement monitoring for the EKS cluster using Helm to deploy Prometheus and Grafana, providing insights into cluster health and performance.

## Step 11: ArgoCD Application Deployment

Deploy the three-tier application using ArgoCD, including the database, backend, frontend, and ingress components.

## Step 12: DNS Configuration

Configure DNS settings to allow access to the application through custom subdomains.

## Step 13: Data Persistence

Set up persistent volumes and persistent volume claims for database pods to ensure data persistence.

## Step 14: Conclusion and Monitoring

Summarize the project’s key achievements and monitor the EKS cluster’s performance using Grafana.
