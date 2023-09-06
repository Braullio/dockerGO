# Dockerfile para uma Aplicação Go

Este é um exemplo de Dockerfile que permite criar uma imagem Docker para uma aplicação Go. Esta imagem utiliza duas etapas para criar uma imagem final pequena e segura usando a imagem "golang:1.20-bullseye" como base.

## Etapas do Dockerfile

### Etapa 1: Builder

1. Define a imagem base como "golang:1.20-bullseye" e nomeia esta etapa como "builder".

2. Instala o Go 1.20 mais recente usando `go install` e faz o download usando `go1.20 download`.

3. Define o diretório de trabalho como "/app".

4. Copia todo o conteúdo do contexto de construção (seu projeto Go) para o diretório de trabalho.

5. Executa `go mod tidy` para ajustar e organizar o arquivo go.mod e manter as dependências em ordem.

6. Compila a aplicação Go com diversas configurações de compilação, como desativação do CGO, definição do sistema operacional como Linux e a criação do executável "server" no diretório raiz ("/") com remoção de informações de símbolos e depuração.

### Etapa 2: Imagem Final

1. Define a imagem base como "gcr.io/distroless/base-debian11" para criar uma imagem final mínima e segura baseada no Debian 11.

2. Define o diretório de trabalho como o diretório raiz ("/").

3. Copia o executável "server" da etapa anterior (nomeada "builder") para o diretório raiz ("/") nesta etapa.

4. Expõe a porta 8080, que pode ser usada para acessar a aplicação (certifique-se de que sua aplicação esteja escutando nesta porta).

5. Define o usuário como "nonroot:nonroot" para aumentar a segurança do container.

6. Define o ponto de entrada (entrypoint) como "/server" para iniciar a aplicação quando o container for iniciado.

## Como usar este Dockerfile

1. Certifique-se de ter o Docker instalado em sua máquina.

2. Clone seu projeto Go para um diretório local.

3. Crie uma imagem Docker usando o Dockerfile. Você pode fazer isso com o seguinte comando no mesmo diretório do Dockerfile:

```bash
docker build -t nome-da-sua-imagem .
```

Execute um container com a imagem criada:
```bash
docker run -p 8080:8080 nome-da-sua-imagem
```

Sua aplicação Go estará acessível na porta 8080 do seu host.