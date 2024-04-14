# Use uma imagem base do Ruby
FROM ruby:3.2.3

# Instale as dependências do sistema necessárias para o Rails
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Crie o diretório de trabalho na imagem Docker
RUN mkdir /bank_accounting
WORKDIR /bank_accounting

# Copie o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instale as gems especificadas no Gemfile.lock
RUN bundle install

# Copie o restante do código da aplicação para o contêiner
COPY . .

# Exponha a porta 3000 para o host, para que a aplicação Rails possa ser acessada
EXPOSE 3000

# Comando para inicializar o servidor Rails quando o contêiner for iniciado
CMD ["rails", "server", "-b", "0.0.0.0"]
