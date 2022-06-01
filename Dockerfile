FROM golang:1.18-alpine AS build

LABEL autodelete="true"

RUN apk update && \
    apk add curl \
            git \
            bash \
            make && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# copy module files first so that they don't need to be downloaded again if no change
COPY go.* ./
RUN go mod download

# copy source files and build the binary
COPY . .
RUN make build

FROM alpine:latest
WORKDIR /app/

COPY --from=build /app/postgres_sqlc_guide .

ENTRYPOINT ["./postgres_sqlc_guide"]  

CMD ["start"]

