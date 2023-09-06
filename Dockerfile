FROM golang:1.20-bullseye as builder

RUN go install golang.org/dl/go1.20@latest \
    && go1.20 download

WORKDIR /app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o /server -trimpath -ldflags="-s -w"

FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY --from=builder /server /server

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/server"]