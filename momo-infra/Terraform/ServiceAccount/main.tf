resource "yandex_iam_service_account" "sa-cert" {
  name        = "yb-cert-sa"
  description = "External Secrets Operator"
}

resource "yandex_iam_service_account" "sa-lockbox" {
  name        = "yb-lockbox-sa"
  description = "Account to view Lockbox secrets"
}

resource "yandex_resourcemanager_folder_iam_binding" "payloadViewer" {
  folder_id = var.folder_id
  role      = "lockbox.payloadViewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-lockbox.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "downloader" {
  folder_id = var.folder_id
  role      = "certificate-manager.certificates.downloader"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-cert.id}"
  ]
}

# Not in use
# resource "yandex_iam_service_account_key" "sa-cert-auth-key" {
#   service_account_id = yandex_iam_service_account.sa-cert.id
#   description        = "key for External Secrets Operator service account"
#   key_algorithm      = "RSA_2048"
# }

# output "sa-cert-auth-key-public" {
#   description = "Public key for External Secrets Operator"
#   value       = yandex_iam_service_account_key.sa-cert-auth-key.public_key
#   sensitive   = false
# }

# output "sa-cert-auth-key-private" {
#   description = "Private key for External Secrets Operator"
#   value       = yandex_iam_service_account_key.sa-cert-auth-key.private_key
#   sensitive   = true
# }