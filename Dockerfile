FROM python:3.8.15-slim-buster

USER root

WORKDIR /src

COPY ./requirements.txt requirements.txt

# Dependencies required for psycopg2 (used for Postgres client)
RUN apt update -y && apt install -y build-essential libpq-dev

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install --upgrade pip setuptools wheel && pip install -r requirements.txt

COPY . .

ENV DB_USERNAME=myuser \
DB_PASSWORD=mypassword \
DB_HOST=127.0.0.1 \
DB_PORT=5433 \
DB_NAME=mydatabase

CMD python app.py
