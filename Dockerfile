# Use Go base image
FROM golang:1.23.4-alpine as builder

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Download dependencies
RUN go mod tidy

# Build the application
RUN go build -o main .

# Run stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .

# Expose port
EXPOSE 8080

# Command to run the executable
CMD ["./main"]