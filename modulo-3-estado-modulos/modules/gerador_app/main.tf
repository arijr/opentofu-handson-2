resource "local_file" "manifesto_app" {
  filename = "${var.diretorio_saida}/${var.nome_app}-manifest.json"
  content = jsonencode({
    app_name   = var.nome_app
    port       = var.porta
    status     = "configured"
    created_at = timestamp()
  })
}
