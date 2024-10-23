# Parking API

## Tecnologia utilizada

| Tipo            | Ferramenta                                                         |
| --------------- | ------------------------------------------------------------------ |
| Database        | [PostgreSQL](https://www.postgresql.org/)                          |
| Docker          | [Docker](https://www.docker.com/)                                  |
| Docker Compose  | [Docker Compose](https://docs.docker.com/compose/)                 |
| Framework       | [Rails](https://rubyonrails.org/)                                  |
| Language        | [Ruby](https://www.ruby-lang.org/pt/)                              |
| Linter          | [Rubocop](https://github.com/rubocop/rubocop)                      |
| Tests           | [RSpec](https://github.com/rspec/rspec-rails)                      |

## Dockerfile para teste
No projeto a dois dockerfiles:
1. `Dockerfile.development` utilizado para o projeto local.
2. `Dockerfile` utilizado para o deploy de teste.

## Ambiente de desenvolvimento
Para subir o projeto localmente, basta utilizar o seguinte comando: \
`docker compose up parking_api_dev`

Onde após toda a configuração realizada, o projeto estara rodando no seguinte endereço `0.0.0.0:3000`.

## Testes unitários
Após subir o projeto utilizando docker, acesse o container `docker compose exec parking_api_dev bash` e utilize o seguinte comando para rodar os testes unitários do projeto: \
`bundle exec rspec`

## Linter
Após subir o projeto utilizando docker, acesse o container `docker compose exec parking_api_dev bash` e utilize o seguinte comando para rodar o linter do projeto: \
`bundle exec rubocop`

## Ações que podem ser realizadas

### Entrada
Cria um novo registro de estacionamento, retornando um `parking_id` para que seja utilizado para pagamento e saida posteriormente.
A API aceita a seguinte máscara para placas `AAA-A1F1`, utilizando uma mascara com base nas placas atuais do Brasil, ou seja, os 3 primeiros caracteres devem ser letras seguido de hífen e o restante pode ser letra e/ou números.

```
POST /parking

body: { plate: 'FAA-1234' }

response: { "parking_id": 9 }, status: 201 Created
```

Caso tente registrar uma placa com valor inválido, o seguinte erro será retornado:
```
{ "error": "Validation failed: Plate is invalid" }
```

### Pagamento
Realiza o pagamento do estacionamento.

```
PUT /parking/:id/pay

response: {}, status: 200 OK
```

Caso tente pagar duas vezes com o mesmo `parking_id`, o seguinte erro será retornado:
```
response: { "error": "Parking already paid" }, status: 400 Bad Request
```

### Saída
Registra a saída do estacionamento.

```
PUT /parking/:id/out

response: {}, status: 200 OK
```

Caso tente sair sem realizar o pagamento antes, o seguinte erro será retornado:
```
response: { "error": "Parking must be paid" }, status: 400 Bad Request
```

Caso tente sair duas vezes com o mesmo `parking_id`, o seguinte erro será retornado:
```
response: { "error": "Vehicle already out" }, status: 400 Bad Request
```

### Histórico
Mostra um histórico de registros de estacionamentos utilizando a placa do carro (`plate`).

```
GET /parking/:plate

response:
  [
    {"id": 6,"time": "0 minutes","paid": true,"left": true},
    {"id": 7,"time": "0 minutes","paid": true,"left": true}
  ]
```
