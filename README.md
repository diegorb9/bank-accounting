## Configurações do Projeto
### Requisito
* Linux / Mac OSX
* [Ruby 2.6.5](https://www.ruby-lang.org)
* [PostgreSQL 10.9](https://www.postgresql.org)
* [Bundler gem](https://github.com/bundler/bundler)

### Instalar gems e dependências

    $ bundle install

### Criar banco de dados e rodar migrações

    $ rails db:create db:migrate

### Popular banco de dados para testes funcionais (opcional)

    $ rails db:seed

### Rodando o server

    $ rails server

### Rodando a suíte de testes

1. Preparar banco de testes (se não criado anteriormente):

        $ rails db:test:prepare

2. Rodar suíte de testes:

        $ COVERAGE=true rspec

4. Verificar relatório de cobertura de testes:

        $ open ./coverage/index.html

## Funcionalidades

Os enpoints podem ser testados [AQUI](https://bank-accounting.herokuapp.com/) com as contas abaixo:

- Luke -> access_token: '1fda26a7bbbb8a5e4c2f', account_id: 1

- Anakin -> access_token: 'd4ec0d06c6231542ef4e', account_id: 2

- McDuck -> access_token: 'c43ccccf616be94f90a6', account_id: 3

---

***COLOQUE ESSES HEADERS NA REQUEST:***

Authorization => Token token={access_token da conta}
Content-Type  => application/json


***IMPORTANTE***:
Qualquer requisição em que a conta de origem, seja para transferência ou consulta de saldo, não corresponda ao token informado, será respondida com ***401***.

### Consultar saldo de uma conta

`GET https://bank-accounting.herokuapp.com/api/v1/accounts/:account_id`

Exemplo:
```shell
curl --request GET \
  --url https://bank-accounting.herokuapp.com/api/v1/accounts/1 \
  --header 'authorization: Token token=1fda26a7bbbb8a5e4c2f' \
  --header 'content-type: application/json'
```

Resposta:
```json
{
  "data": {
    "id": "1",
    "type": "account",
    "attributes": {
      "customer_id": 1,
      "balance": 100.0
    }
  }
}
```

### Transferir um valor para outra conta

`POST https://bank-accounting.herokuapp.com/api/v1/transfers`

Corpo:
```json
{
	"source_account_id": 1,
	"destination_account_id": 2,
	"amount": 27.00
}
```

Exemplo:
```shell
curl --request POST \
  --url https://bank-accounting.herokuapp.com/api/v1/transfers \
  --header 'authorization: Token token=1fda26a7bbbb8a5e4c2f' \
  --header 'content-type: application/json' \
  --data '{
	"source_account_id": 1,
	"destination_account_id": 2,
	"amount": 27.00
}'
```

Resposta em caso de sucesso: ***201***

Resposta em caso de falha: ***422***
```json
{
  "source_account_id": [
    "saldo insuficiente"
  ]
}
```
