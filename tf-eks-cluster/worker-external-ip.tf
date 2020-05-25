# Worker External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local worker to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#

data "http" "worker-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  worker-external-cidr = "${chomp(data.http.worker-external-ip.body)}/32"
}
