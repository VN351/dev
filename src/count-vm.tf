data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_os_family}"
}

resource "yandex_compute_instance" "web" {
  count = 2
  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
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

    scheduling_policy {
    preemptible = var.preemptible.yes
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = var.nat.yes
  }

  metadata = local.metadata
  
  allow_stopping_for_update = var.stop_vm.yes

  depends_on = [yandex_compute_instance.platform2]

}