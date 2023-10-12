# Base image
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Receive API Key as a build argument
ARG API_KEY

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV API_KEY=$API_KEY

# Run this before copying requirements for cache efficiency
RUN pip install --upgrade pip

# Adding requirements file to current directory
COPY requirements.txt .

# Update pip and install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the port that the FastAPI application will run on
EXPOSE 8000

# Start the FastAPI application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
