variable "region" {
  default = "us-west-2"
}

variable "account" {
  default = "default"
}

# Role managed by tf-automation-iam-role
variable "deploy_role" {
  default = "arn:aws:iam::351484734788:role/automation-role"
}

variable "env" {
  default = "dev"
}

# VPC Parameters
variable "vpc-name" {
  default = "digital-devops-eks-vpc"
}


# Cluster Parameters
variable "cluster-name" {
  default = "digital-devops-eks-cluster"
}

variable "cluster_policy_arn" {
  default = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy", "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"]
}


# Worker Node Parameters
variable "worker-name" {
  default = "digital-devops-eks-worker"
}

variable "worker_policy_arn" {
  default = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
}

