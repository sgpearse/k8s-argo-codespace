FROM python:3.9

COPY flask-app/ .

RUN pip install -r requirements.txt

CMD ["python3", "./wsgi.py"]