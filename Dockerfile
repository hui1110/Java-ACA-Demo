FROM maven:latest as builder
RUN pwd
RUN mvn clean install

FROM openjdk:8
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
