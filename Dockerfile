# First Stage: Build the application using Maven
FROM maven:3.8.6-eclipse-temurin-17 AS builder

# Set working directory inside the container
WORKDIR /app

# Copy only the necessary files for dependency resolution
COPY app/pom.xml ./
RUN mvn dependency:go-offline

# Copy the entire source code and build the application
COPY app/src ./src
RUN mvn clean package -DskipTests

# Second Stage: Create a lightweight final image
FROM eclipse-temurin:17-jdk-jammy

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=builder /app/target/*.jar app.jar

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]
