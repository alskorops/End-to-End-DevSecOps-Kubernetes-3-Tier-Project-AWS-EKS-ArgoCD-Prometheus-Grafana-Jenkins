* Create AWS ID and Key 
* S3 bucket for our terraform state file.
* DynamoDB table lock-file
* Create ssh-key and paste the name to variables.tfvars -> key-name

## Terraform Installation Script 

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg - dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y
```
## AWSCLI Installation Script 
``` 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y 
unzip awscliv2.zip 
sudo ./aws/install 
```
macos ```brew install awscli```

## EKS cluster: 
Creatre EKS cluster: <br>
``` eksctl create cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 --node-type t3.medium --nodes-min 2 --nodes-max 2 ```

to destroy after: <br>
``` eksctl delete cluster --name Three-Tier-K8s-EKS-Cluster --region us-east-1 ```
 
To configure kubectl to connect to the cluster: <br>
``` aws eks update-kubeconfig --region us-east-1 --name Three-Tier-K8s-EKS-Cluster ``` 

## Grant access to EKS cluster: 
Create access entry for the user: <br>
``` aws eks create-access-entry --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> ```
    
Associate access policy with user <br>
``` aws eks associate-access-policy --cluster-name Three-Tier-K8s-EKS-Cluster --region us-east-1 --principal-arn arn:aws:iam::<accound_id>:user/<username> --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy --access-scope type=cluster ```


##  Configure the Load Balancer
Download the policy for the LoadBalancer prerequisite. <br>
``` curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json ```

Create the IAM policy using the below command <br>
``` aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json ```

Create OIDC Provider <br>
``` eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=Three-Tier-K8s-EKS-Cluster --approve ```

Create a Service Account by using below command and replace your account ID with your one <br>
``` eksctl create iamserviceaccount --cluster=Three-Tier-K8s-EKS-Cluster --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::<your_account_id>:policy/AWSLoadBalancerControllerIAMPolicy --approve --region=us-east-1 ```

Run the below command to deploy the AWS Load Balancer Controller <br>
```
sudo snap install helm --classic
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=my-cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
```

After 2 minutes, run the command below to check whether your pods are running or not.
``` kubectl get deployment -n kube-system aws-load-balancer-controller ```

## Login to ECR after cretion 
```aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <accound_id>.dkr.ecr.us-east-1.amazonaws.com```

## Get ArgoCD default password 
``` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ```
