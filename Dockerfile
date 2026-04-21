FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*
COPY . .
RUN pip install --no-cache-dir neo4j openai python-dotenv flask flask-cors requests numpy pandas
EXPOSE 5001
# This starts the ACTUAL MiroShark engine inside the backend folder
CMD ["python", "backend/run.py"]
