FROM node:12.18-alpine3.9 as builder

RUN mkdir /project-build
WORKDIR /project-build

COPY package.json package.json

RUN npm install --silent

COPY . .

RUN npm run-script build

FROM python:3.7-slim-buster 

RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY --from=builder /project-build /app

LABEL maintainer="Ryuichi Miyazaki <rmiyazaki11@ucsbalum.com>"

CMD ./start.sh
