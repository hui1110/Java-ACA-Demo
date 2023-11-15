FROM maven:3.8.1-jdk-8 as maven-builder
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -DskipTests

FROM openjdk:8
COPY --from=maven-builder app/target/*.jar /app-service/app.jar
WORKDIR /app-service
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
