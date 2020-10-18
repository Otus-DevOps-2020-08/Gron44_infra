provider "yandex" {
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = module.vpc.external_vpc_id
  db_ip            = module.db.external_ip_address_db
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = module.vpc.external_vpc_id
}

module "vpc" {
  source         = "../modules/vpc"
  zone           = var.zone
  v4_cidr_blocks = var.v4_cidr_blocks
}
