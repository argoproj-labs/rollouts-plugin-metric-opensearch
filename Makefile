.PHONY: build-rollouts-plugin-metric-opensearch-debug
build-rollouts-plugin-metric-opensearch-debug:
	CGO_ENABLED=0 go build -gcflags="all=-N -l" -o rollouts-plugin-metric-opensearch main.go

.PHONY: build-rollouts-plugin-metric-opensearch
build-rollouts-plugin-metric-opensearch:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o rollouts-plugin-metric-opensearch-linux-amd64 main.go
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o rollouts-plugin-metric-opensearch-linux-arm64 main.go
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o rollouts-plugin-metric-opensearch-darwin-amd64 main.go
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w" -o rollouts-plugin-metric-opensearch-darwin-arm64 main.go

tag-release:
	if [[$(TAG) == v?.?.?]]; then echo "Tagging $(TAG)"; elif [[$(TAG) == v?.?.??]]; then echo "Tagging $(TAG)"; else echo "Bad Tag Format: $(TAG)"; exit 1; fi && git tag -a $(TAG) -m "Releasing $(TAG)" ; read -p "Push tag: $(TAG)? " push_tag ; if ["${push_tag}"="yes"]; then git push self $(TAG); fi