#!/bin/bash

GITHUB_USERNAME="ruandg"

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

export PATH="$PATH:$(go env GOPATH)/bin"

mkdir -p golang/order
mkdir -p golang/payment

protoc --go_out=golang/order --go_opt=paths=source_relative \
  --go-grpc_out=golang/order --go-grpc_opt=paths=source_relative \
  order/order.proto

protoc --go_out=golang/payment --go_opt=paths=source_relative \
  --go-grpc_out=golang/payment --go-grpc_opt=paths=source_relative \
  payment/payment.proto

cd golang/order
go mod init github.com/${GITHUB_USERNAME}/microservices-proto/golang/order 2>/dev/null || true
go mod tidy
cd ../../

cd golang/payment
go mod init github.com/${GITHUB_USERNAME}/microservices-proto/golang/payment 2>/dev/null || true
go mod tidy
cd ../../
