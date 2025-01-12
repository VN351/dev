###cloud vars
/*
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vms_ssh_root_key" {
  description = "Путь к публичному SSH ключу"
  type        = string
  default     = "/home/vlad/.ssh/id_ed25519.pub"
}

variable "vm_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family"  
}

variable "platform_id" {
  description = "Выбор платформы"
  type = map(string)
  default = {
    "pi1" = "standard-v1"
    "pi2" = "standard-v2"
    "pi3" = "standard-v3"
  }   
 }

variable "nat" {
  description = "Включение NAT"
  type = map(string)
  default = {
    "yes" = "true"
    "no"  = "false"
  }
}

variable "ssh_username" {
  description = "Имя пользователя для SSH ключей"
  type        = string
  default     = "ubuntu"
}

variable "vms_resurces" {
  description = "Ресурсы VM web"
  type        = map(map(number))
  default = {
    vm_web_resources = {
      core = 2
      memory = 1
      core_fraction = 5
    }
    vm_db_resources = {
      core = 2
      memory = 2
      core_fraction = 20  
    }
  }
}

variable "each_vm" {
  description = "Ресурсы VM db"
  type        = list(object({
    vm_name = string
    cpu  = number
    ram  = number
    core_fraction = number
    disk_volume = number
  }))
  default     = [{
    vm_name = ""
    cpu = 2
    ram = 2
    core_fraction = 20
    disk_volume = 10
  },
  {
    vm_name = ""
    cpu = 2
    ram = 1
    core_fraction = 5
    disk_volume = 5
  }
  ]
}