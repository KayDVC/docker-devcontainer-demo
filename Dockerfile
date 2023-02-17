FROM python:alpine3.16

WORKDIR /flaskapp

RUN apk update

RUN apk add git

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 4001

