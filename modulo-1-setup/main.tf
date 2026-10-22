terraform {
  required_version = ">= 1.6.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

resource "local_file" "boas_vindas" {
  filename = "${path.module}/hello.txt"
  content  = "Ambiente OpenTofu configurado com sucesso no Módulo 1!\n"
}
