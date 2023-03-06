
locals {
  cidr_internet = "0.0.0.0/0" # All IPv4 addresses.
}

resource "yandex_vpc_network" "network-momo" {
  description = "Network for the momo project"
  name        = "network-momo"
}

resource "yandex_vpc_subnet" "subnet-dev" {
  description    = "Subnet for the Dev instance"
  name           = "subnet-dev"
  network_id     = yandex_vpc_network.network-momo.id
  v4_cidr_blocks = ["10.128.1.0/24"]
  zone           = "ru-central1-a"
}


resource "yandex_vpc_security_group" "sg-internet" {
  description = "Allow any outgoing traffic to the Internet"
  name        = "sg-internet"
  network_id  = yandex_vpc_network.network-momo.id

  egress {
    description    = "Allow any outgoing traffic to the Internet"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = [local.cidr_internet]
  }
}

resource "yandex_vpc_security_group" "sg-dev-instance" {
  description = "Security group for the DEV instance"
  name        = "sg-dev-instance"
  network_id  = yandex_vpc_network.network-momo.id

  ingress {
    description    = "Allow HTTP connections to the DEV instance"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [local.cidr_internet]
  }

  ingress {
    description    = "Allow HTTPs connections to the DEV instance"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = [local.cidr_internet]
  }

  ingress {
    description    = "Allow SSH connections to the DEV instance"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.cidr_internet]
  }

}
