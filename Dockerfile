FROM alpine:latest
WORKDIR /app
COPY --from=clone /Java-ACA-Demo /app

FROM maven:latest as builder
RUN cd /app
RUN mvn clean install

FROM openjdk:8
ARG JAR_FILE=app/target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
