FROM maven:3-eclipse-temurin-8-alpine as build
COPY . /app
WORKDIR /app
RUN mvn clean install
RUN ls -la target

COPY ./ ./

COPY  ./target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar /app/target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar

ENTRYPOINT java -jar /app/target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar
