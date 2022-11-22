data "template_file" "shell" {
  template = file(var.scfile)

  vars = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
  }
}

locals {
  settings_linux = {
    script = "${base64encode(data.template_file.shell.rendered)}"
  }
}

resource "azurerm_virtual_machine_extension" "linux" {
  name                 = "run-chromium-test"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  protected_settings   = jsonencode(local.settings_linux)

  timeouts {
    create = "2h"
    delete = "30m"
  }

}