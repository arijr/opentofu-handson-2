output "caminho_arquivo" {
  value       = local_file.config_servidor.filename
  description = "Caminho do ficheiro gerado"
}

output "id_randomico" {
  value       = random_string.sufixo.result
  description = "Sufixo aleatório gerado"
}
