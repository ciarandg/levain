variable "linode_token" {
  type = string
  sensitive = true
}

data "local_file" "ssh_public_key" {
  filename = "${path.module}/example_ed25519.pub"
}

data "local_sensitive_file" "ssh_private_key" {
  filename = "${path.module}/example_ed25519"
}

module "node" {
  source            = "github.com/ciarandg/levain//terraform/platform/node-linode"
  nixos_config_name = "example"
  ssh_public_key    = trimspace(data.local_file.ssh_public_key.content)
  ssh_private_key   = data.local_sensitive_file.ssh_private_key.content
  env_suffix        = "-development"
}
