
locals {
  cidr_internet = "0.0.0.0/0" # All IPv4 addresses.
}

data "yandex_vpc_network" "network-momo" {
  name        = "network-momo"
}

resource "yandex_vpc_subnet" "subnet-k8s" {
  description    = "Subnet for the k8s instance"
  name           = "subnet-k8s"
  network_id     = data.yandex_vpc_network.network-momo.id
  v4_cidr_blocks = ["10.128.2.0/24"]
  zone           = "ru-central1-a"
}

resource "yandex_iam_service_account" "sa-k8s" {
  name = "yb-k8s-sa"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  # Assign "editor" role to service account.
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-k8s.id}"
  ]
}

# Managed Service for Kubernetes cluster
resource "yandex_kubernetes_cluster" "k8s-cluster" {
  description = "Managed Service for Kubernetes cluster"
  name        = "k8s-cluster"
  network_id  = data.yandex_vpc_network.network-momo.id

  master {
    version = "1.23"
    zonal {
      zone      = yandex_vpc_subnet.subnet-k8s.zone
      subnet_id = yandex_vpc_subnet.subnet-k8s.id
    }

    public_ip = true

    #security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]

  }
  service_account_id      = yandex_iam_service_account.sa-k8s.id # Cluster service account ID
  node_service_account_id = yandex_iam_service_account.sa-k8s.id # Node group service account ID
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor
    #yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_kubernetes_node_group" "k8s-node-group" {
  description = "Node group for Managed Service for Kubernetes cluster"
  name        = "k8s-node-group"
  cluster_id  = yandex_kubernetes_cluster.k8s-cluster.id
  version     = "1.23"

  scale_policy {
    fixed_scale {
      size = 1 # Number of hosts
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.subnet-k8s.id]
      #security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id, yandex_vpc_security_group.k8s-public-services.id]
    }

    resources {
      memory = 4 # RAM quantity in GB
      cores  = 4 # Number of CPU cores
    }

    boot_disk {
      type = "network-hdd"
      size = 64 # Disk size in GB
    }
  }
}