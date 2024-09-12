# Stage 1: Set up PostgreSQL
FROM postgres:14 as postgres

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=sfdc
ENV POSTGRES_DB=flask_db

# Expose PostgreSQL port
EXPOSE 5432


# Stage 2: Set up Flask App
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the necessary packages
COPY --from=postgres /app /app
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose the port Flask will run on
EXPOSE 5000

# Command to run both PostgreSQL and Flask
CMD service postgresql start && python app.py
