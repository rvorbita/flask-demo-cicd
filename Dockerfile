FROM python:3.11-slim

# Working directory
WORKDIR /app
# Environment
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install updates    
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt to the current directory
COPY requirements.txt .

# install the requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy the file to the current app directory
COPY . .

# Expose the port 5000
EXPOSE 5000

# Execute gunicorn, localhost port 5000 
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
