FROM maven:latest as builder
RUN cd Java-ACA-Demo
RUN mvn clean install

FROM openjdk:8
RUN pwd
ARG JAR_FILE=Java-ACA-Demo/target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
