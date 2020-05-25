provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
}

provider "aws" {
  region = var.replica_region
  alias  = "replica"
}
