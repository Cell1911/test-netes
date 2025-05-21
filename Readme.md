
## A containerized Python web app that uses Redis and PostgreSQL, deployed to a Kubernetes cluster. The infrastructure is provisioned with Terraform on AWS, and the app is deployed using `kind` and `kubectl`.

test-netes-main/
├── app/ # Python web app with Flask
│ ├── app.py
│ ├── requirements.txt
│ └── templates/
│ └── index.html
├── kubernetes/ # Kubernetes manifests
│ ├── db-secret.yaml
│ ├── postgres-deployment.yaml
│ ├── postgres-pvc.yaml
│ ├── postgres-service.yaml
│ ├── redis-deployment.yaml
│ ├── redis-service.yaml
│ ├── testnetes-deployment.yaml
│ └── testnetes-service.yaml
├── terraform/ # Infrastructure as Code for AWS
│ ├── main.tf
│ ├── variables.tf
│ ├── output.tf
│ ├── terraform.tfvars
│ ├── install.sh # Script to install Docker, Kind, kubectl on EC2
│ └── my-key.pem # SSH private key (do not expose publicly)
├── Dockerfile # Docker image for the app
├── docker-compose.yml # Optional local Docker test setup
├── .env # Environment variables for local use
└── install.sh # Global setup script

Ensure the following tools are installed **locally**:

- Docker
- kubectl
- Kind
- Terraform
- AWS CLI (configured)
- A valid EC2 key pair (`.pem`)


### 1. Build Docker Image

```bash
docker build -t testnetes .
```

### 2. Login to Docker Hub

```bash
docker login
```
(Enter your Docker Hub username and password when prompted.)

### 3. Tag Docker Image

Replace `yourdockerhubusername` with your actual Docker Hub username:

```bash
docker tag kubernetes-html-app yourdockerhubusername/kubernetes-html-app:latest
```

### 4. Push Docker Image

```bash


docker push yourdockerhubusername/kubernetes-html-app:latest
```

Once done with docker we can now build the architecture for our deployment, so we will be using ***terraform*** here 


### 1. Go inside Terraform directory

```bash
cd terraform
```

### 1. Initiliaze terraform

```bash
terraform init
```

### 3. all the configurations are for t3.xlarge because we need a machine with maximum CPU capacity to deploy minikube/kind cluster

```bash
terraform plan
```

### 4. Once you can see the required architecure provided by plan stage is valid then you can apply the plan

```bash
terraform apply
```

This sets up:

A custom VPC

A security group with open ports

An EC2 instance with public IP and SSH access

## now you can copy this repo on your instance and then

## Create Kubernetes Cluster with Kind
```bash
kind create cluster --name testnetes
```

## Deply to kubernetes 
```bash
kubectl apply -f kubernetes/db-secret.yaml
kubectl apply -f kubernetes/postgres-pvc.yaml
kubectl apply -f kubernetes/postgres-deployment.yaml
kubectl apply -f kubernetes/postgres-service.yaml
kubectl apply -f kubernetes/redis-deployment.yaml
kubectl apply -f kubernetes/redis-service.yaml
kubectl apply -f kubernetes/testnetes-deployment.yaml
kubectl apply -f kubernetes/testnetes-service.yaml
```bash

## Test the Application

kubectl get pods
kubectl get svc

# Port-forward the app
kubectl port-forward svc/testnetes-service 5000:5000


## Clean-up

# From EC2
kind delete cluster --name testnetes

# From your machine
cd terraform
terraform destroy


