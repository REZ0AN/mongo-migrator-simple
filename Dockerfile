FROM alpine:latest

# Install MongoDB Database Tools
RUN apk add --no-cache mongodb-tools

# Copy migration script
COPY migrate-mongo.sh /migrate-mongo.sh
RUN chmod +x /migrate-mongo.sh

WORKDIR /app

CMD ["/migrate-mongo.sh"]