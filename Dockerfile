# Stage 1: The Build Stage
FROM rust:1.96-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /app
COPY . .
RUN cargo build --release

# Stage 2: The Lightweight Runtime Stage
FROM alpine:3.24
WORKDIR /app
# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/hello_docker .
# Run as a non-root user for security
RUN adduser -D appuser
USER appuser
CMD ["./hello_docker"]

