FROM ruby:2.6.7

# Copy src code to app directory
COPY . /app
WORKDIR /app

# Make entrypoint.sh executable
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./app/docker-entrypoint.sh"]