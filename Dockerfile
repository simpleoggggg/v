# Use Ubuntu 22.04 base
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    nodejs \
    npm \
    unzip \
    bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Ensure permissions for the application folder
RUN chmod -R 755 /app

# Upgrade pip and install requirements
RUN python3 -m pip install --upgrade pip && \
    pip3 install -r requirements.txt

# Railway-compatible port
EXPOSE 5000

# Start the application
CMD ["python3", "app.py"]
