NAME = kaniabi/errbot
VERSION = 0.1

.PHONY: all build test latest release

all: build

build:
	sudo docker build -t $(NAME):$(VERSION) -t $(NAME):latest .

release:
	git tag ${VERSION}
	git push origin
	git push origin --tags
