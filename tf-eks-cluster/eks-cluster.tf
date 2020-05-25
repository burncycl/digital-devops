# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster

resource "aws_iam_role" "cluster-role" {
  name               = "${var.cluster-name}-${var.env}-role"
  assume_role_policy = file("./iam-cluster-policy.json")
}

resource "aws_iam_role_policy_attachment" "cluster-policy" {
  count      = length(var.cluster_policy_arn)
  role       = aws_iam_role.cluster-role.name
  policy_arn = element(var.cluster_policy_arn, count.index)
}

resource "aws_security_group" "cluster-sg" {
  name        = "${var.cluster-name}-${var.env}-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster-name}-${var.env}-sg"
  }
}

resource "aws_security_group_rule" "cluster-worker-ingress" {
  cidr_blocks       = [local.worker-external-cidr]
  description       = "Allow worker to communicate with the cluster API Server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster-sg.id
  type              = "ingress"
}

resource "aws_eks_cluster" "default" {
  name     = var.cluster-name
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster-sg.id]
    subnet_ids         = aws_subnet.default[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.cluster-policy]
}
