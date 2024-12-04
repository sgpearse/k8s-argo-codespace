FROM python:3.10-slim

# Copy in the Flask application code
COPY flask-app/ .

# Install the python requirements
RUN pip install -r requirements.txt

# Run the application
CMD ["python3", "./wsgi.py"]