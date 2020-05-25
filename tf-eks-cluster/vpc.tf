# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "${var.vpc-name}-${var.env}-vpc",
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}", "shared",
  )
}

resource "aws_subnet" "default" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.default.id

  tags = map(
    "Name", "${var.vpc-name}-${var.env}-sn",
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}", "shared",
  )
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.cluster-name}-${var.env}-ig"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
}

resource "aws_route_table_association" "default" {
  count          = 2
  subnet_id      = aws_subnet.default.*.id[count.index]
  route_table_id = aws_route_table.default.id
}
