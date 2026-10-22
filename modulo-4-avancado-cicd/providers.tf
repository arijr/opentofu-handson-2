terraform {
  required_version = ">= 1.7.0"

  encryption {
    key_provider "pbkdf2" "chave_curso" {
      passphrase = "SenhaDoCursoOpenTofu2026!"
    }

    method "aes_gcm" "cripto_padrao" {
      keys = key_provider.pbkdf2.chave_curso
    }

    state {
      method   = method.aes_gcm.cripto_padrao
      enforced = true
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}
