variable "linode_token" {
  type = string
  sensitive = true
}

variable "ssh_private_key" {
  type = string
  sensitive = true
}

variable "ssh_public_key" {
  type = string
}

module "node" {
  source            = "github.com/ciarandg/levain//terraform/platform/node-linode"
  nixos_config_name = "example"
  ssh_public_key    = var.ssh_public_key
  ssh_private_key   = var.ssh_private_key
  env_suffix        = "-development"
}
