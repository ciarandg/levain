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
variable "install_extra_files_script" {
  description = <<-EOT
  The filename of a script that, when run, writes files to the working directory.

  This script will run on the provisioning machine, and then the output files
  will be copied over to the root directory on the remote host before install.
  Use this for passing secrets to the NixOS machine without putting them in the
  Nix store.
  EOT
  type = string
  default = null
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