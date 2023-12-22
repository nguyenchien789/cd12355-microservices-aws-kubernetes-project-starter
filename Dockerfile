FROM python:3.10-slim-buster

USER root

WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY ./analytics .

CMD service postgresql start && python app.py
