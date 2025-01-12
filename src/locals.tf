locals {
    metadata = {
        "serial-port-enable" = "1"
        "ssh-keys"           = "${var.ssh_username}:${file(var.vms_ssh_root_key)}"
    }
}