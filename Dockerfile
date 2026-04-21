# Use a slim version of Python 3.11 (saves ~800MB)
FROM python:3.11-slim

# Install light system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only the requirement files first to save build time
COPY requirements.txt .

# Install CPU-only versions of AI libraries (This is the secret to 4.8GB -> 1.2GB)
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the engine
COPY . .

# Expose the ports for WorkfloWyze
EXPOSE 3000
EXPOSE 5001

# Launch the swarm
CMD ["python", "app.py"]
