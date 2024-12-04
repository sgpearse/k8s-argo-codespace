FROM python:3.10-slim

COPY flask-app/ .

RUN pip install -r requirements.txt

CMD ["python3", "./wsgi.py"]