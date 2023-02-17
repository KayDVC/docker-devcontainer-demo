FROM python:alpine3.16

WORKDIR /flaskapp

# Add git to devconatiner
RUN apk update

RUN apk add git

# Install SSH Client
RUN apk add openssh

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 4001

