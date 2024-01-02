resource "azurerm_virtual_machine_scale_set" "vmscale" {
  name                = "mytestscaleset-1"
  location            = var.location
  resource_group_name = var.resource_group_name

  upgrade_policy_mode = "Automatic"  

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 2
  }
  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }
  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "Divya"
    admin_password       = "Divya@123"  # Ensure the password is complex enough to meet Azure’s password requirements
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  network_profile {
    name    = "terraformnetworkprofile"
    primary = true
    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = var.subnet_3aa_id

    
    }
  }
  tags = {}

}

resource "azurerm_monitor_autoscale_setting" "vmscale_setting" {
  name                = "myAutoscaleSetting"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_virtual_machine_scale_set.vmscale.id

  profile {
    name = "setting_profile"

    capacity {
      default = 2
      minimum = 2
      maximum = 6
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.vmscale.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 30
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "autoscale_name"
          operator = "Equals"
          values   = ["mytestscalest-1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.vmscale.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 5
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  predictive {
    scale_mode      = "Enabled"
    look_ahead_time = "PT5M"
  }
}

