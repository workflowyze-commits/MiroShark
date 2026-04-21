# 1. Use a slim Python engine to keep the business lightweight and under 500MB
FROM python:3.11-slim

# 2. Install basic internet tools (curl) for system health checks
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# 3. THE MASTER COMMAND: This copies EVERYTHING from your GitHub 
# (including the /backend folder) into the cloud engine. 
# This is how the agents "see" the whole project.
COPY . .

# 4. DIRECT INSTALL: We bypass both requirements.txt files to avoid confusion.
# This installs the memory (neo4j), the brain (openai), and the web tools.
RUN pip install --no-cache-dir neo4j openai python-dotenv flask flask-cors requests numpy pandas

# 5. Open the communication ports for your website and the agents
EXPOSE 3000
EXPOSE 5001

# 6. START: This hits the master switch (app.py) sitting in your root folder.
CMD ["python", "app.py"]
