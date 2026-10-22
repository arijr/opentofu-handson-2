output "arquivo_manifesto" {
  value       = local_file.manifesto_app.filename
  description = "Caminho do manifesto gerado pelo módulo"
}
