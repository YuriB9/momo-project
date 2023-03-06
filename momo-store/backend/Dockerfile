FROM gitlab.praktikum-services.ru:5050/std-009-060/momo-store/golang:1.17 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum /app/

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . /app

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app /app/...

######## Start a new stage from scratch #######
FROM gitlab.praktikum-services.ru:5050/std-009-060/momo-store/alpine:3.17.2

WORKDIR /app

RUN apk --no-cache add curl

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/api /app/api

# Expose port 8081 to the outside world
EXPOSE 8081

# Command to run the executable
CMD ["/app/api"]