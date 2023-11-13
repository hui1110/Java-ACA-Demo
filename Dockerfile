FROM maven:3.8.1-openjdk-8
COPY . /app
WORKDIR app
RUN mvn clean install
RUN ls -la
COPY target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar /app/
RUN ls -la
ARG JAR_FILE=Java-ACA-Demo-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT java -jar /app.jar
