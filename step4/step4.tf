resource "azurerm_public_ip" "lb_pip" {
  name                = "tf-lb-pip"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "tf_lab_lb" {
  name                = "tf-lb"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name

  frontend_ip_configuration {
    name                 = "lb-pip"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  resource_group_name = azurerm_resource_group.apprg.name
  loadbalancer_id     = azurerm_lb.tf_lab_lb.id
  name                = "backend_pool"
}

resource "azurerm_lb_rule" "lb-rule" {
  resource_group_name            = azurerm_resource_group.apprg.name
  loadbalancer_id                = azurerm_lb.tf_lab_lb.id
  name                           = "rule-01"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb-pip"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  probe_id                       = azurerm_lb_probe.health_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool" {
  count = var.server_count
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}
resource "azurerm_lb_probe" "health_probe" {
  resource_group_name = azurerm_resource_group.apprg.name
  loadbalancer_id     = azurerm_lb.tf_lab_lb.id
  name                = "http-running-probe"
  port                = 80
}
output "Load_Balencer_IP_Address" {
  value = azurerm_public_ip.lb_pip.ip_address
}
