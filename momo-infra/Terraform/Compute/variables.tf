
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

variable "username" {
  type        = string
  description = "User to login"
  default     = "ansible"
}

variable "ssh_public_key" {
  type        = string
  description = "Path to public_key for SSH login"
}

variable "zone" {
  type        = string
  description = "Yandex Cloud compute default zone"
  default     = "ru-central1-a"
}

variable "name" {
  description = "Yandex Cloud Compute instance name"
  type        = string
}

variable "image_id" {
  description = "Yandex Cloud Compute Image ID"
  type        = string
}

variable "hostname" {
  description = "Host name for the instance"
  type        = string
}

variable "platform_id" {
  description = "The type of virtual machine to create"
  type        = string
  default     = "standard-v1"
}

variable "cores" {
  description = "CPU cores for the instance"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory size for the instance in GB"
  type        = number
  default     = 1
}

variable "core_fraction" {
  description = "Baseline performance for a core as a percent"
  type        = number
  default     = 5
}

variable "preemptible" {
  description = "Specifies if the instance is preemptible"
  type        = bool
  default     = true
}

variable "size" {
  description = "Size of the boot disk in GB"
  type        = string
  default     = "40"
}


variable "network_zones" {
  type        = set(string)
  description = "Yandex Cloud network zones"
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

variable "access_key" {
  description = "static access key"
  type        = string
}

variable "secret_key" {
  description = "secret for static access key"
  type        = string
}