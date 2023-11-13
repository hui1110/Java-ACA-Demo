FROM maven:3-eclipse-temurin-8-alpine as build
COPY . /app
WORKDIR app
RUN mvn clean install
RUN ls -la target
RUN pwd
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
