FROM ruby:2.7.6-bullseye

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /docker/app

# Expose port for Rails server
EXPOSE 3000

# Run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
