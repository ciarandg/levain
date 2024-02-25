module "instance" {
  source = "../../hardware/instance-linode"
  env_suffix = var.env_suffix
  ssh_public_key = var.ssh_public_key
}

module "nixos-installation" {
  source = "../../software/nixos-installation"
  config_name = var.nixos_config_name
  install_user_profile = {
    username = "root"
    ssh_host = module.instance.ip_address
  }
  install_user_ssh_private_key = var.ssh_private_key
  user_profile = {
    username = "nixos"
    ssh_host = module.instance.ip_address
  }
  user_ssh_private_key = var.ssh_private_key
  extra_files = [
    {
      filename = "nixos_hashed_password"
      contents = sha512("password")
    },
    {
      filename = "nixos_authorized_keys"
      contents = var.ssh_public_key
    }
  ]
  depends_on = [module.instance]
}
