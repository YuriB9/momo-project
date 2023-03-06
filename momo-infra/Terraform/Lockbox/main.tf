
resource "yandex_lockbox_secret" "gitlab_token_infra" {
  name      = "gitlab_token_infra"
  folder_id = var.folder_id
}

resource "yandex_lockbox_secret_version" "gitlab_token_infra_version" {
  secret_id = yandex_lockbox_secret.gitlab_token_infra.id
  entries {
    key        = "url"
    text_value = "https://gitlab.praktikum-services.ru/std-009-060/momo-infra.git"
  }
  entries {
    key        = "username"
    text_value = "gitlab-ci-token"
  }
  entries {
    key        = "password"
    text_value = var.infra_token
  }
}

resource "yandex_lockbox_secret" "gitlab_token_app" {
  name      = "gitlab_token_app"
  folder_id = var.folder_id
}

resource "yandex_lockbox_secret_version" "gitlab_token_app_version" {
  secret_id = yandex_lockbox_secret.gitlab_token_app.id
  entries {
    key        = "url"
    text_value = "https://gitlab.praktikum-services.ru/std-009-060/momo-store.git"
  }
  entries {
    key        = "username"
    text_value = "gitlab-ci-token"
  }
  entries {
    key        = "password"
    text_value = var.app_token
  }
}
