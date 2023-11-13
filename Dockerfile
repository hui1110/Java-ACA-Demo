FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/hui1110/Java-ACA-Demo.git

FROM alpine:latest
COPY --from=clone /app/repository /app


#FROM maven:latest as builder
#RUN mvn clean install
#
#FROM openjdk:8
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT java -jar /app.jar
