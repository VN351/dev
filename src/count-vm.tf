data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_os_family}"
}

resource "yandex_compute_instance" "web" {
  count = 2
  name        = "web-${count.index + 1}"
  platform_id = var.platform_id.pi1

  resources {
    cores         = var.vms_resurces.vm_web_resources.core
    memory        = var.vms_resurces.vm_web_resources.memory
    core_fraction = var.vms_resurces.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = var.nat.yes
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_root_key)}"
  }
  
  allow_stopping_for_update = true

}