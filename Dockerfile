# Use Ubuntu 22.04 base
FROM ubuntu:22.04

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy everything from your local repo to the container
COPY . .

# 1. Upgrade pip to ensure modern flag support
# 2. Unzip the SPECIFIED h.zip file
# 3. Fix permissions for execution
# 4. Install dependencies from requirements.txt
RUN python3 -m pip install --upgrade pip && \
    unzip -o h.zip && \
    chmod -R 755 /app && \
    pip3 install -r requirements.txt

# Railway-compatible port
EXPOSE 5000

# Start the application
CMD ["python3", "app.py"]
