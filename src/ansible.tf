resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/host.tftpl",
    {
      webservers  = yandex_compute_instance.web,
      databases   = yandex_compute_instance.platform2,
      storage     = yandex_compute_instance.storage
    }
  )
}

resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.storage, local_file.inventory]
  
  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && cat /home/vlad/.ssh/id_ed25519 | ssh-add -"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    # without secrets
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/inventory.ini ${abspath(path.module)}/test.yml"


    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }

  #срабатывание триггера при изменении переменных
  triggers = {
    always_run      = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
    always_run_uuid = "${uuid()}"
    #playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    #ssh_public_key    = var.public_key                           # при изменении переменной with ssh
    #template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    #password_change = jsonencode( {for k,v in random_password.each: k=>v.result})
  }
}
