# Use the slimmest version of Python available
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install only the absolute system essentials
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# BYPASS: Install the tools directly in the command line (No requirements.txt needed)
# Notice: 'torch' is removed to keep the size under 500MB
RUN pip install --no-cache-dir neo4j openai python-dotenv flask flask-cors requests numpy pandas

# Copy all your code into the engine
COPY . .

# Open the ports for WorkfloWyze
EXPOSE 3000
EXPOSE 5001

# Launch the swarm
CMD ["python", "app.py"]
