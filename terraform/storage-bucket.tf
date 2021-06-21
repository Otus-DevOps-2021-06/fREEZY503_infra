terraform {
  backend "s3" {
    endpoint    = "storage.yandexcloud.net"
    bucket      = "freezy503"
    region      = "ru-central1"
    key         = "terraform.tfstate"
    access_key  = "WTZ93JliyxqfQmCuBzj9"
    secret_key  = "zeWB-gZ2ZtqcZYqE_QsijPj11JtNF6d8j8snT-yA"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
