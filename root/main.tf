module "vnet" {
  source = "../modules/vnet"
  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address-space       = var.address-space
  pub_sub_1_a_prefixes = var.pub_sub_1_a_prefixes
  pub_sub_2_b_prefixes = var.pub_sub_2_b_prefixes
  pri_sub_3_a_prefixes = var.pri_sub_3_a_prefixes
  pri_sub_4_b_prefixes = var.pri_sub_4_b_prefixes
  pri_sub_5_a_prefixes = var.pri_sub_5_a_prefixes
  pri_sub_6_b_prefixes = var.pri_sub_6_b_prefixes
}

module "vmscaleset" {
  source = "../modules/vmscaleset"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_3aa_id = module.vnet.subnet_3a_id
}