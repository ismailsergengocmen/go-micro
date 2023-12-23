## BUILD PHASE ##
# base go image
FROM golang:1.18-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# Make the binary file 'brokerApp' executable
RUN chmod +x /app/brokerApp

## FINAL PHASE ##

FROM alpine:latest

RUN mkdir /app

# Copy only the binary from the builder stage
COPY --from=builder /app/brokerApp /app

# Specify the default command to run when the container starts
CMD ["/app/brokerApp"]