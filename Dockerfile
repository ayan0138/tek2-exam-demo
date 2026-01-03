# ---- MULTISTAGE Dockerfile ----
# Build stage
FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:resolve #optimize build by caching dependencies
COPY src ./src
RUN mvn clean package -DskipTests #optimize build by caching dependencies


# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]


# Example of non-multistage Dockerfile
#FROM maven:3.9.11-eclipse-temurin-21
#WORKDIR /app
#COPY pom.xml .
#RUN mvn dependency:resolve
#COPY src ./src
#RUN mvn clean package -DskipTests
#RUN mv target/*.jar target/app.jar
#CMD ["java", "-jar", "app.jar"]