output "vm" {
  description = "Список всех виртуальных машин с именем, ID и FQDN"
  value = concat(

    [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.hostname
      }
    ],
    
    [
      for key, vm in yandex_compute_instance.platform2 : {
        name = vm.name
        id   = vm.id
        fqdn = vm.hostname
      }
    ],
    
    [
      {
        name = yandex_compute_instance.storage.name
        id   = yandex_compute_instance.storage.id
        fqdn = yandex_compute_instance.storage.hostname
      }
    ]
  )
}

output "rc_list_01_to_99" {
  value = local.rc_list_01_to_99
}

output "rc_list_filtered" {
  description = "Отфильтрованный список от rc01 до rc96"
  value       = local.rc_list_01_to_96_filtered
}