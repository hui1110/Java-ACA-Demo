FROM maven:3.8.1-jdk-8
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install
RUN ls -la target
COPY  target/Java-ACA-Demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT java -jar /app.jar
