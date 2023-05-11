FROM openjdk:8-jre-alphine

EXPOSE 8080

COPY ./target/java-maven-app-1.0-SNAPSHOTS.jar /usr/app/
WORKDIR /usr/app/

ENTRYPOINT [ "java", "-jar", "java-maven-app-1.0-SNAPSHOT.jar"]
