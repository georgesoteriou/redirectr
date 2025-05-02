FROM alpine:latest

# Install socat
RUN apk add --no-cache socat

# Copy the entrypoint script into the container
COPY ./entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable (redundant if you did it locally, but good practice)
RUN chmod +x /entrypoint.sh

# Set environment variables (these will be available to the entrypoint script)
ENV LISTEN_ADDRESS="0.0.0.0"
ENV LISTEN_PORTS=""
ENV FORWARD_ADDRESS="0.0.0.0"
ENV FORWARD_PORTS=""

# Set the entrypoint to execute the script
ENTRYPOINT ["/entrypoint.sh"]

# You can still define a CMD, but it will be passed as arguments to the ENTRYPOINT
# CMD ["some", "optional", "arguments"]
