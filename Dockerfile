# Use an official Ruby image as the base
FROM ruby:3.1-alpine

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy the project code from the host machine
COPY . .

# Install bundle (gem dependency manager)
RUN gem install bundler

# Install project dependencies using the Gemfile
RUN bundle install --production

# Expose the default Rails port (3000)
EXPOSE 3000

# Define the command to run when the container starts (rails server)
CMD ["rails", "server", "-b", "0.0.0.0"]
