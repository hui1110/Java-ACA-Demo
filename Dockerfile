FROM maven:3.8.1-jdk-8 as maven-builder
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -DskipTests

FROM openjdk:8
COPY --from=maven-builder app/target/*.jar /app-service/app.jar
WORKDIR /app-service
RUN wget -O agent.jar https://huiagentaccount.blob.core.windows.net/agent-8/java-accelerator-agent-0.0.1-SNAPSHOT.jar
RUN wget -O javassist.jar https://repo1.maven.org/maven2/org/javassist/javassist/3.29.2-GA/javassist-3.29.2-GA.jar
EXPOSE 8080
ENTRYPOINT ["java","-javaagent:agent.jar", "-jar", "app.jar"]
