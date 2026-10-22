variable "nome_app" {
  type        = string
  description = "Nome da aplicação"
}

variable "porta" {
  type        = number
  description = "Porta de execução do serviço"
  default     = 8080
}

variable "diretorio_saida" {
  type        = string
  description = "Diretório de destino dos manifestos"
  default     = "."
}
