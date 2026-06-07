resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
  addon_version              = "v1.21.1-eksbuild.8"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  configuration_values = jsonencode({
    env = {
      ENABLE_PREFIX_DELEGATION = "true"
      WARM_IP_TARGET           = "2"
      MINIMUM_IP_TARGET        = "1"
      AWS_VPC_K8S_CNI_EXTERNALSNAT = "true"
    }
  })

  service_account_role_arn = aws_iam_role.vpc_cni.arn

  #  depends_on = [aws_eks_cluster.this]
}
