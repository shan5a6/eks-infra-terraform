locals {
  node_max_pods = var.max_no_of_pods
}

data "aws_ssm_parameter" "eks_al2023_x86_64_ami" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks-cluster.version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

resource "aws_launch_template" "private_nodes" {
  name_prefix = "private-nodes-"

  image_id      = data.aws_ssm_parameter.eks_al2023_x86_64_ami.value
  instance_type = var.private_nodes_type
  key_name      = var.keypair

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOUNDARY"

--BOUNDARY
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${aws_eks_cluster.eks-cluster.name}
    apiServerEndpoint: ${aws_eks_cluster.eks-cluster.endpoint}
    certificateAuthority: ${aws_eks_cluster.eks-cluster.certificate_authority[0].data}
    cidr: ${aws_eks_cluster.eks-cluster.kubernetes_network_config[0].service_ipv4_cidr}
  kubelet:
    config:
      maxPods: ${local.node_max_pods}

--BOUNDARY--
EOF
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "private-nodes"
    }
  }
}

resource "aws_launch_template" "public_nodes" {
  name_prefix = "public-nodes-"

  image_id      = data.aws_ssm_parameter.eks_al2023_x86_64_ami.value
  instance_type = var.public_nodes_type
  key_name      = var.keypair

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOUNDARY"

--BOUNDARY
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${aws_eks_cluster.eks-cluster.name}
    apiServerEndpoint: ${aws_eks_cluster.eks-cluster.endpoint}
    certificateAuthority: ${aws_eks_cluster.eks-cluster.certificate_authority[0].data}
    cidr: ${aws_eks_cluster.eks-cluster.kubernetes_network_config[0].service_ipv4_cidr}
  kubelet:
    config:
      maxPods: ${local.node_max_pods}

--BOUNDARY--
EOF
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "public-nodes"
    }
  }
}


