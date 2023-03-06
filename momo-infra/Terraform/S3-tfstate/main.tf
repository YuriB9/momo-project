
data "yandex_iam_service_account" "sa" {
  name = "yb-tfstate-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${data.yandex_iam_service_account.sa.id}"
}

resource "yandex_storage_bucket" "s3-tfstate" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "s3-tfstate"
}
