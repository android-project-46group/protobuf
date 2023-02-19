.PHONY: generate help mock
.DEFAULT_GOAL := help

generate:
	protoc --go_out=./gen --go-grpc_out=./gen ./*.proto
	cd ./gen/go/protobuf && go mod tidy

help:	## https://postd.cc/auto-documented-makefile/
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

mock:	## mock を生成する
	cd gen/go/protobuf && \
	mockgen -package mockpb -destination mock/mock.go \
	github.com/android-project-46group/protobuf/gen/go/protobuf \
	DownloadClient,Download_DownloadMembersZipClient,DownloadServer,Download_DownloadMembersZipServer
