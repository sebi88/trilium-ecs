terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

variable "data_volume_snapshot_id" {
  type = string
}

locals {
  name = "trilium2"
  zone_letter = "a"
}

module "disk" {
  source = "./modules/disk"
  data_volume_snapshot_id = var.data_volume_snapshot_id
  name = local.name
  zone_letter = local.zone_letter
}