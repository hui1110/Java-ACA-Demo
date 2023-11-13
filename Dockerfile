FROM maven:latest as builder
RUN pwd
WORKDIR Java-ACA-Demo
RUN ls -l
RUN mvn clean install

FROM openjdk:8
RUN pwd
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
