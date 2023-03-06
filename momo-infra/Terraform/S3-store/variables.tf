
variable "token" {
  description = "token to access yandex cloud"
  type        = string
}

variable "cloud_id" {
  description = "cloud id where to create the sources"
  type        = string
}

variable "folder_id" {
  description = "folder id where to create the sources"
  type        = string
}

variable "access_key" {
  description = "static access key"
  type        = string
}

variable "secret_key" {
  description = "secret for static access key"
  type        = string
}

variable image_names {
    type = list(string)
    description = "list of all image names"
}

