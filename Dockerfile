FROM maven:latest as builder
COPY . /app
WORKDIR app
RUN mvn clean install
RUN ls -la
COPY /app/target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar app.jar

FROM openjdk:8
WORKDIR /app
RUN ls -la
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
