# Using the standard version instead of "slim" to avoid connection errors
FROM python:3.11

# Set the working directory
WORKDIR /app

# Copy the requirements file we just made
COPY requirements.txt .

# Install the lightweight CPU version of AI tools
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your business logic
COPY . .

# Open the ports
EXPOSE 3000
EXPOSE 5001

# Launch the swarm
CMD ["python", "app.py"]
