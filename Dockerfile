FROM maven:3.8.1-jdk-8 as maven-builder
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -DskipTests

FROM openjdk:8-alpine
COPY --from=maven-builder app/target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar /app-service/Java-ACA-Demo-0.0.1-SNAPSHOT.jar
WORKDIR /app-service
EXPOSE 8080
ENTRYPOINT ["java","-jar","Java-ACA-Demo-0.0.1-SNAPSHOT.jar"]
