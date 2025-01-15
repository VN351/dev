resource "yandex_compute_disk" "additional_disk" {
  count = 3

  name = "disk-${count.index + 1}"
  size = 1 

  type = "network-hdd"
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = var.platform_id.pi1

  resources {
    cores         = var.vms_resurces.core
    memory        = var.vms_resurces.memory
    core_fraction = var.vms_resurces.core_fraction
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional_disk 

    content {
      disk_id     = secondary_disk.value.id
    }
  }

  metadata = local.metadata

  allow_stopping_for_update = var.stop_vm.yes
}