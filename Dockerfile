FROM maven:3.8.1-openjdk-8
COPY . /app
WORKDIR app
RUN mvn clean package
RUN ls -la
RUN cd target
RUN ls -la

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
