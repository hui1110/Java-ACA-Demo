FROM maven:latest as builder
COPY . /app
WORKDIR app
RUN mvn clean install

FROM openjdk:8
WORKDIR /app
RUN pwd
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
