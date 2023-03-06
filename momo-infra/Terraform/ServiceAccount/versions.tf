terraform {
  required_version = ">= 1.1.6"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "s3-tfstate"
    region     = "ru-central1"
    key        = "sa.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

}
