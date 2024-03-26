# Use Python 3.9 slim image as the base
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements.txt to the working directory
COPY requirements.txt .

# Install Python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy application content
COPY /service ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]