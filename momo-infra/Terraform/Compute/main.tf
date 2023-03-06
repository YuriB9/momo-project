
locals {
  cidr_internet = "0.0.0.0/0" # All IPv4 addresses.
}

data "template_file" "user_data" {
  template = file("cloud-config.yml")

  vars = {
    username        = var.username
    ssh_public_key  = file(var.ssh_public_key)
  }
}

data "yandex_iam_service_account" "sa-static-key" {
  name = "yb-tfstate-sa"
}

data "yandex_vpc_subnet" "subnet-dev" {
  name = "subnet-dev"
}

data "yandex_vpc_security_group" "sg-internet" {
  name = "sg-internet"
}

data "yandex_vpc_security_group" "sg-dev-instance" {
  name = "sg-dev-instance"
}

resource "yandex_compute_instance" "this" {
  name        = var.name
  hostname    = var.hostname
  zone        = var.zone
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = var.preemptible
  }

  resources {
    core_fraction = var.core_fraction
    cores         = var.cores
    memory        = var.memory
  }

  boot_disk {
    initialize_params {
      size     = var.size
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.subnet-dev.subnet_id
    nat       = true

    security_group_ids = [
      data.yandex_vpc_security_group.sg-internet.id,    # Allow any outgoing traffic to Internet.
      data.yandex_vpc_security_group.sg-dev-instance.id # Allow connections to and from the Yandex Managed k8s.
    ]
  }

  metadata = {
    user-data          = data.template_file.user_data.rendered
    serial-port-enable = 1
  }

}
