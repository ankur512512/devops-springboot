# First Stage: Compile & Build the application
FROM maven:3.9.9-eclipse-temurin-17-alpine AS builder

WORKDIR /app

COPY app/pom.xml ./
RUN mvn -B dependency:go-offline

COPY app/src ./src
RUN mvn -B clean package -DskipTests

# Second Stage: Create a lightweight final image
FROM eclipse-temurin:17-jdk-alpine-3.21 AS runtime

# Fix CVE-2025-0840 detected by Trivy
RUN apk update && apk upgrade

WORKDIR /app

# Use least privilege user
USER nobody

COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
