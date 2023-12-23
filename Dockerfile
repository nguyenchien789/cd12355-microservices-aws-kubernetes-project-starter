FROM python:3.10-slim-buster

USER root

WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY ./analytics .

CMD python app.py
