# Use a lightweight base image
FROM alpine:latest

# Install necessary dependencies
RUN apk --no-cache add wget tar bash

# Set up working directory
WORKDIR /tmate

# Download and extract TMATE
RUN wget -nc https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-i386.tar.xz && \
    tar -xvf tmate-2.4.0-static-linux-i386.tar.xz && \
    rm tmate-2.4.0-static-linux-i386.tar.xz

# Set up TMATE session in the Docker entrypoint
ENTRYPOINT ["sh", "-c", "nohup ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock new-session -d && disown -a && ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock wait tmate-ready && ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'"]
