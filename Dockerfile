FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Copy and make the script executable
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

# Install fortune-mod and cowsay
RUN apt-get update \
    && apt-get install -y fortune-mod cowsay netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Update PATH to include /usr/games
ENV PATH="/usr/games:${PATH}"

# Expose port 4499
EXPOSE 4499

# Run the script
CMD ["/app/wisecow.sh"]
