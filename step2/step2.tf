resource "azurerm_public_ip" "apppip" {
  count               = var.server_count
  name                = "${var.name}${(count.index + 1)}-pip"
  resource_group_name = azurerm_resource_group.apprg.name
  location            = azurerm_resource_group.apprg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  count               = "${var.server_count}"
  name                = "${var.name}${(count.index + 1)}-nic"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name

  ip_configuration {
    name                          = "ifconfig"
    subnet_id                     = azurerm_subnet.appsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.apppip[count.index].id
  }
}
resource "azurerm_linux_virtual_machine" "webvm" {
  count               = var.server_count
  name                = "${var.name}${(count.index + 1)}"
  resource_group_name = azurerm_resource_group.apprg.name
  location            = azurerm_resource_group.apprg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "file" {
    source      = "startup.sh"
    destination = "/tmp/startup.sh"
    connection {
      type     = "ssh"
      user     = "adminuser"
      private_key = "${file("~/.ssh/id_rsa")}"
      host     = azurerm_network_interface.nic[count.index].public_ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/startup.sh",
    ]
  }
}
