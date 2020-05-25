# EKS Worker Nodes Resources

#IAM role allowing Kubernetes actions to access other AWS services
resource "aws_iam_role" "worker-role" {
  name               = "${var.worker-name}-${var.env}-role"
  assume_role_policy = file("./iam-worker-policy.json")
}

resource "aws_iam_role_policy_attachment" "worker-policy" {
  count      = length(var.worker_policy_arn)
  role       = aws_iam_role.worker-role.name
  policy_arn = element(var.worker_policy_arn, count.index)
}

# EKS Node Group to launch worker nodes
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "${var.worker-name}-${var.env}-ng"
  node_role_arn   = aws_iam_role.worker-role.arn
  subnet_ids      = aws_subnet.default[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [aws_iam_role_policy_attachment.worker-policy]
}
