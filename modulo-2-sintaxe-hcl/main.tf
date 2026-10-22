resource "random_string" "sufixo" {
  length  = 6
  special = false
  upper   = false
}

resource "local_file" "config_servidor" {
  filename = "${path.module}/config-${var.ambiente}-${random_string.sufixo.result}.txt"
  content  = <<EOT
=========================================
STATUS DO SERVIDOR - AMBIENTE: ${upper(var.ambiente)}
=========================================
Hash de identificação: ${random_string.sufixo.result}
Conteúdo: ${var.conteudo_base}
=========================================
EOT
}
