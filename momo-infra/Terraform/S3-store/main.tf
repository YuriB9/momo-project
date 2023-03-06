
data "yandex_iam_service_account" "sa" {
  name = "yb-tfstate-sa"
}

resource "yandex_storage_bucket" "s3-store" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "s3-store"
  max_size   = 20971520

  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }
}

resource "yandex_storage_object" "momo" {
  count      = 8
  bucket     = "s3-store"
  key        = var.image_names[count.index]
  access_key = var.access_key
  secret_key = var.secret_key
  source     = ".\\images\\${var.image_names[count.index]}"
}
