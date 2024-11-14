1. Create AWS ID and Key 
2. S3 bucket for our terraform state file.
3. DynamoDB table lock-file
4. Create ssh-key and paste the name to variables.tfvars -> key-name
5. Create EKS cluster: 
*    ``` eksctl create cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 --node-type t3.medium --nodes-min 2 --nodes-max 2 ```

to destroy after:
*   ``` eksctl delete cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 ```

6. To configure kubectl to connect to the cluster:

*    ``` aws eks update-kubeconfig --region us-east-1 --name Three-Tier-K8s-EKS-Cluster ```
7. Grant access to EKS cluster:<br>
    a. Create access entry for the user: 
    * ``` aws eks create-access-entry --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> ``` 
    <br> b. Associate access policy with user 
    * ``` aws eks associate-access-policy --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy --access-scope type=cluster ```
8. Login to ECR after cretion 
* ```aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <accound_id>.dkr.ecr.us-east-1.amazonaws.com```
9. Get ArgoCD default password 
* ``` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ```
10. Create OIDC Provider
* ``` eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=Three-Tier-K8s-EKS-Cluster --approve ```