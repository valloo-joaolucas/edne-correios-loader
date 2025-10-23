#!/bin/sh

# Mudar para o diretório de trabalho do container
cd /app

# Ativar o ambiente virtual

# Executar o comando de ajuda do edne-correios-loader
edne-correios-loader load --help

# Executar o comando para execução da atualizacao do CEP
edne-correios-loader load \
  --database-url postgresql://$DB_USERNAME:$DB_PASSWORD@$DB_URL_CEP?options=-c%20search_path=dne \
  --tables $DNE_PARAM