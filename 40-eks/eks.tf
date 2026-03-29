resource "aws_key_pair" "eks" {
  key_name   = "roboshop-eks"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjF/A2q9lM+CRFjOU7kLGemBvqooqsl1HuWEu9U/eQ2kJJZWgthK3CEFSHlkQA+I425RiJQPDfx04Fr+/GB8/b3tKzUE96nSba+04HZiHmk5chUaEWS5pkBbv4oJFWCzPNPdcW/bCW13MPaf/4385F68t8WjzbXIN7KSrwv6yIeOIG2Ng/DKIv66HLOGQV++B9rPR8Y7pfnNgOfiCfzu8H9wZ5BsMezaKD04VtAJfCH7SNph2Uuzebu99RppXaWRs4GRI8EYxbyGsIBNyTsbI7AL/o3beb9JibR/uIaKThFjkzhX/fFnMT2p5OwfjoFuZ34lx4cnmbxg26qB6NVweNueTuH9LK/nfAvEwXBcByk8EBGGes0Rc7DleS0mRIoIOlf5zgBbYq4ZM/rpy9yrKR6ZQfUx4AYrbsN/6HF2PLbFbwucdRjWHM3W9vaFngPK82kQFPC4JRTTIcKoZhVb2h8P2V0KoailL9bP6kb8cvr4q5ucymr8iNDYsgQJ0PZ4anNmvmyVhB8f9qcdNRlqpnUpyOTxH/E84ZVctWWfm9U8R8jb8RwpoCLo//alR0yTDK/OSPIgrrl0mhdRw9OvM2lFquYM+Gs7MIF2AyPeGSq8Q0E/Bd+FPr26UWZs6Fq3bEoWxzESQgGKBmb2O0/LRLUwPykbTEa8XEeMXTeSD1mw== User@DESKTOP-G6TJASC"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.name
  cluster_version = "1.32" # later we upgrade 1.32
  create_node_security_group = false
  create_cluster_security_group = false
  cluster_security_group_id = local.eks_control_plane_sg_id
  node_security_group_id = local.eks_node_sg_id

  #bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    metrics-server = {}
  }

  # Optional
  cluster_endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    /* blue = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2_x86_64"
      instance_types = ["m5.xlarge"]
      key_name = aws_key_pair.eks.key_name

      min_size     = 2
      max_size     = 10
      desired_size = 2
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        AmazonEKSLoadBalancingPolicy = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
    } */

    green = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2_x86_64"
      instance_types = ["m7i-flex.large"]
      key_name = aws_key_pair.eks.key_name

      min_size     = 2
      max_size     = 10
      desired_size = 2
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        AmazonEKSLoadBalancingPolicy = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
    }
  }

  tags = merge(
    var.common_tags,
    {
        Name = local.name
    }
  )
}