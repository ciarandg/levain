variable "config_name" {
  description = "NixOS configuration name. Used in flake path, e.g. .#nixosConfigurations.foo"
  type = string
}

variable "install_user_profile" {
  description = "User profile at installation time (a user on the machine from before NixOS is installed)"
  type = object({
    username = string
    ssh_host = string
  })
}
variable "install_user_ssh_private_key" {
  description = "The private key to authenticate with at installation time"
  type = string
  sensitive = false
}

variable "user_profile" {
  description = "User profile after install (the primary user on this NixOS install)"
  type = object({
    username = string
    ssh_host = string
  })
}
variable "user_ssh_private_key" {
  description = "The private key to authenticate with after install"
  type = string
  sensitive = false
}

variable "extra_files" {
  description = <<-EOT
  A list of file names and contents that will be copied into the root directory of
  the node. Use this for passing secrets to the NixOS machine without putting them
  in the Nix store.
  EOT
  type = list(object({
    filename = string
    contents = string
  }))
}
