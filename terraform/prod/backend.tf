terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "homework9-bucket-prod"
    region     = "ru-central1"
    key        = "prod/terraform.tfstate" 
    access_key = "ahuN5i8BrYogK5MBJw1v"
    secret_key = "0PoT3VnvpVaIAbMQ392EfsPqJGTC_lHN-3LvAd3u"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
