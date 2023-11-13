FROM maven:latest as builder
RUN ls -l
COPY . /app
WORKDIR app
RUN ls -l
RUN mvn clean install
RUN ls -l
RUN pwd

FROM openjdk:8
RUN pwd
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
