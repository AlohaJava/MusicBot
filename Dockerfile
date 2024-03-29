# Use a base image with Java 11 and Maven installed
FROM maven:3.6.3-jdk-11-slim AS build

# Copy your project files into the image
COPY ./ /usr/src/app
WORKDIR /usr/src/app

# Build your project and package it
RUN mvn clean package

# Use a base image with just Java 11 for running your application
FROM openjdk:11-jre-slim

# Copy the built jar and config.txt into the image
COPY --from=build /usr/src/app/target/*.jar /usr/app/JMusicBot.jar
COPY config.txt /usr/app/config.txt

# Create an empty Playlists directory
RUN mkdir /usr/app/Playlists

WORKDIR /usr/app

# Command to run your app
CMD ["java", "-jar", "JMusicBot.jar"]
