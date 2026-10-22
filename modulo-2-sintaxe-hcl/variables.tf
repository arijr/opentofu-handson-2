variable "ambiente" {
  type        = string
  description = "Ambiente de implantação (dev, staging, prod)"
  default     = "dev"
}

variable "conteudo_base" {
  type        = string
  description = "Texto base gravado no ficheiro"
  default     = "Servidor ativo e operacional."
}
