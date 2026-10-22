resource "aws_s3_bucket" "sistema_migrado" {
  bucket = "minicurso-opentofu-migrado"

  tags = {
    Projeto = "minicurso-opentofu"
    Modulo  = "avancado-cicd"
  }
}
