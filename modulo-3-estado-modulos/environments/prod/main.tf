module "app_frontend" {
  source = "../../modules/gerador_app"

  nome_app        = "frontend-web-prod"
  porta           = 8080
  diretorio_saida = "${path.module}/build"
}

module "app_backend" {
  source = "../../modules/gerador_app"

  nome_app        = "backend-api-prod"
  porta           = 3000
  diretorio_saida = "${path.module}/build"
}
