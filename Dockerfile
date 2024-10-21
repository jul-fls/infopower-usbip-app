# Use the official OpenJDK 17 JRE image as the base image
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app

# Set environment variables for remote USB device
ENV USBIP_SERVER=""
ENV USBIP_BUS_ID=""

# Install required packages (usbip and other dependencies)
RUN apt-get update && apt-get install -y \
    iputils-ping \
    unzip \
    usbip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add JAVA_HOME and PATH for Java to be found
ENV JAVA_HOME=/usr/local/openjdk-17
ENV PATH="$JAVA_HOME/bin:$PATH"

# Copy the binary executable to the container
COPY InfoPower.zip /app/InfoPower.zip

# Unzip the binary
RUN unzip InfoPower.zip

# Make the binary executable
RUN chmod +x /app/InfoPower/InfoPower

# Entry script to connect to the remote USB device and start the binary
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port 15178 for external access
EXPOSE 15178

# Set the entrypoint script as the container's startup command
ENTRYPOINT ["/app/entrypoint.sh"]
