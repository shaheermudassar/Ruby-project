# Use an official Ruby image as the base
FROM ruby:latest  # Replace "latest" with a specific version if needed

# Set working directory
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy your application code
COPY . .

# Expose the Rails server port
EXPOSE 3000

# Start the Rails server in development mode (change for production)
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
