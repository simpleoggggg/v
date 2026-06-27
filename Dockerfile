FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# 1. Unzip the file FIRST
# 2. Check for requirements.txt in the current directory and subdirectories
RUN unzip -o h.zip && \
    chmod -R 755 /app && \
    if [ -f requirements.txt ]; then \
        echo "Requirements found!"; \
    else \
        echo "requirements.txt NOT found in root, searching..."; \
        find . -name "requirements.txt"; \
    fi

# Upgrade pip and install if file exists
RUN python3 -m pip install --upgrade pip && \
    if [ -f requirements.txt ]; then \
        pip3 install -r requirements.txt; \
    else \
        echo "Skipping pip install: file not found"; \
    fi

EXPOSE 5000

CMD ["python3", "app.py"]
