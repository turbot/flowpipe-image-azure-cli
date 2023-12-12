# Use the official Azure CLI image as the base image
FROM mcr.microsoft.com/azure-cli

# Copy your docker-entrypoint.sh script into the container
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Set your custom script as the entry point
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
