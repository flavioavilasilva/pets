FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /pets
WORKDIR /pets
COPY Gemfile* ./
RUN gem install bundler && bundle install --jobs=3 --retry=3 
COPY . /pets

# Script que será executado toda vez que o container iniciar
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Inicia o processo principal
CMD ["rails", "server", "-b", "0.0.0.0"]

