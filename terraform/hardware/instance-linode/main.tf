resource "linode_instance" "machine" {
  label = "${var.linode_name}${var.env_suffix}"
  region = "us-southeast"
  type   = "g6-standard-1"
}

resource "linode_instance_disk" "swap" {
  label = "swap"
  linode_id = linode_instance.machine.id
  size = 512
  filesystem = "swap"
}

resource "linode_instance_disk" "root" {
  label = "root"
  linode_id = linode_instance.machine.id
  size = linode_instance.machine.specs.0.disk - linode_instance_disk.swap.size
  image = "linode/ubuntu22.04"
  authorized_keys = [var.ssh_public_key]
}

resource "linode_instance_config" "boot" {
  label = "boot"
  linode_id = linode_instance.machine.id
  kernel = "linode/grub2"
  device {
    device_name = "sda"
    disk_id = linode_instance_disk.root.id
  }
  device {
    device_name = "sdb"
    disk_id = linode_instance_disk.swap.id
  }
  booted = true
}
