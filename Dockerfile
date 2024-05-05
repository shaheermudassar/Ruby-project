# Use official Ruby image with specific version
FROM ruby:2.7.6-alpine

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems and your application code
RUN bundle install && cp -r . .

# Expose port for Rails server
EXPOSE 3000

# Run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
