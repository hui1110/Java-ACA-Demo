FROM maven:latest as builder
COPY ./Java-ACA-Demo /app
WORKDIR app
RUN ls -l
RUN mvn clean install

FROM openjdk:8
RUN pwd
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
