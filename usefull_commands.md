### Create AWS ID and Key 
### S3 bucket for our terraform state file.
### DynamoDB table lock-file
### Create ssh-key and paste the name to variables.tfvars -> key-name
### Terraform Installation Script 

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg - dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y
```
### AWSCLI Installation Script 
``` 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y 
unzip awscliv2.zip 
sudo ./aws/install 
```
macos ```brew install awscli```

### Create EKS cluster: 
``` eksctl create cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 --node-type t3.medium --nodes-min 2 --nodes-max 2 ```

to destroy after:  ``` eksctl delete cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 ```
 
 To configure kubectl to connect to the cluster: ``` aws eks update-kubeconfig --region us-east-1 --name Three-Tier-K8s-EKS-Cluster ```

### Grant access to EKS cluster:<br>
    a. Create access entry for the user: 
    * ``` aws eks create-access-entry --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> ``` 
    <br> b. Associate access policy with user 
    * ``` aws eks associate-access-policy --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy --access-scope type=cluster ```

### Login to ECR after cretion 
```aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <accound_id>.dkr.ecr.us-east-1.amazonaws.com```

### Get ArgoCD default password 
``` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ```

### Create OIDC Provider
``` eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=Three-Tier-K8s-EKS-Cluster --approve ```