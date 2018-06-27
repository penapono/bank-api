# Welcome to the Bank API wiki!
# Basic Setup

## Preparação do Ambiente de Desenvolvimento

``` BASH
rvm install ruby-2.5.1
rvm use 2.5.1
rvm use 2.5.1 gemset create bank_api
rvm use 2.5.1@bank_api
gem install bundler
bundle install
```

## Banco de Dados da Aplicação

### database.yml (Arquivo de configuração do Banco de Dados)

#### Desenvolvimento

``` YAML
default: &default
  adapter: mysql2
  encoding: utf8
  host: localhost
  username: root
  password:
  timeout: 5000

test:
  <<: *default
  database: bank_api_test

development:
  <<: *default
  database: bank_api_development

production:
  <<: *default
  database: bank_api_production
```

### Criar e inicializar banco inicial:

`rake db:drop db:create db:migrate`
