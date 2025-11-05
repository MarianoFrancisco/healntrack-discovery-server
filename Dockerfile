FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY discovery-server/pom.xml .

COPY discovery-server/src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/discovery-server-1.0.0.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]
