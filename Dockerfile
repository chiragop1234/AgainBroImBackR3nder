# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget tar bash && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /tmate

# Download and extract TMATE
RUN wget -nc https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-i386.tar.xz && \
    tar --strip-components=1 -xvf tmate-2.4.0-static-linux-i386.tar.xz && \
    rm tmate-2.4.0-static-linux-i386.tar.xz

# Set up TMATE session in the Docker entrypoint
ENTRYPOINT ["sh", "-c", "nohup ./tmate -S /tmp/tmate.sock new-session -d && disown -a && ./tmate -S /tmp/tmate.sock wait tmate-ready && ./tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'"]
