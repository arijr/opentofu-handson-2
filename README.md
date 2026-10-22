# Minicurso de OpenTofu

Repositório de exemplos práticos organizado por módulos. Execute os comandos
OpenTofu dentro do diretório do módulo que pretende estudar.

Para um passo a passo destinado aos alunos, consulte o
[Roteiro do aluno](./ROTEIRO-ALUNO.md) ou descarregue a
[versão em PDF](./ROTEIRO-ALUNO.pdf).

## Módulos

- `modulo-1-setup`: configura o provider local e cria um ficheiro de boas-vindas.
- `modulo-2-sintaxe-hcl`: demonstra providers, variáveis, interpolação e outputs.
- `modulo-3-estado-modulos`: cria manifestos através de um módulo reutilizável,
  com configurações separadas para `dev` e `prod`.
- `modulo-4-avancado-cicd`: apresenta a configuração de encriptação do estado,
  provisiona um bucket S3 no Floci e inclui um workflow de CI/CD.

## Execução

Em cada diretório de módulo ou ambiente, inicialize e aplique a configuração:

```sh
tofu init
tofu plan
tofu apply
```

Para o Módulo 3, execute estes comandos separadamente em
`modulo-3-estado-modulos/environments/dev` ou
`modulo-3-estado-modulos/environments/prod`.

## Floci (emulador AWS local)

O [Floci](https://floci.io) simula serviços AWS localmente. O Compose inicia o
emulador e uma dashboard web para acompanhar o estado dos recursos. A partir da
raiz do repositório, inicie ambos:

```sh
docker compose up --build -d
```

O endpoint AWS fica disponível em `http://localhost:4566`. Para usar AWS CLI,
OpenTofu ou outra ferramenta compatível, configure o endpoint e credenciais de
desenvolvimento:

```sh
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
```

Abra `http://localhost:8080` para visualizar o estado do Floci e os buckets
S3 existentes. O painel mostra se o bucket do Módulo 4 já foi criado; se estiver
ausente, aplique a configuração OpenTofu para provisioná-lo:

```sh
cd modulo-4-avancado-cicd
tofu init
tofu apply
```

O Módulo 4 configura o provider AWS para encaminhar as chamadas S3 para esse
endpoint. Com o Floci em execução, execute o OpenTofu dentro do diretório do
módulo:

```sh
cd modulo-4-avancado-cicd
tofu init
tofu plan
tofu apply
```

Os módulos 1–3 continuam a usar os providers locais e não criam recursos AWS.
O workflow do GitHub Actions inicia o Floci a partir do `compose.yaml` da raiz,
executa a validação e o plano, e aplica as alterações em pushes para `main`.

Para acompanhar os logs ou parar o Floci:

```sh
cd ..
docker compose logs -f floci dashboard
docker compose down
```

> **Aviso:** a passphrase do Módulo 4 é apenas um valor demonstrativo fornecido
> para o exercício. Não utilize segredos embutidos no código em ambientes reais;
> forneça-os por um mecanismo seguro de gestão de segredos.
