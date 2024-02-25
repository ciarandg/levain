variable "nixos_config_name" {
  description = "NixOS configuration name. Used in flake path, e.g. .#nixosConfigurations.foo"
  type        = string
}

variable "ssh_public_key" {
  description = "The contents of the public key for connecting to your node"
  type        = string
}

variable "ssh_private_key" {
  description = "The contents of the private key for connecting to your node"
  type        = string
  sensitive   = true
}

variable "env_suffix" {
  description = "A suffix to append to resource names, where possible, e.g. \"-staging\" "
  type        = string
  default     = ""
}
