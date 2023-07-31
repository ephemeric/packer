packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "qemu" "ubuntu-2204" {
  headless               = false
  http_directory         = "http"
  iso_checksum           = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
  iso_url                = "ubuntu-22.04.2-live-server-amd64.iso"
  cores                  = 16
  memory                 = 16384
  #qemuargs		 = [
  #  [ "-nodefaults" ]
  #]
  ssh_handshake_attempts = "300"
  ssh_timeout            = "60m"
  ssh_password           = "vagrant"
  ssh_username           = "vagrant"
  disk_size              = "20000M"
  boot_wait		 = "1s"
  boot_key_interval      = "10ms"
  boot_command           = [
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs>",
    "autoinstall ds=\"nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"",
    "<f10>"
  ]
}

build {
  sources = ["source.qemu.ubuntu-2204"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S bash -c '{{ .Vars }} {{ .Path }}'"
    scripts         = ["scripts/update.sh", "scripts/cleanup.sh"]
  }

  post-processor "vagrant" {
    #vagrantfile_template = "./Vagrantfile.template"
    #provider_override = libvirt
  }
}
