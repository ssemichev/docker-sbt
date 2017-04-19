NAME = ssemichev/docker-image:sbt

default: build

debug:
	docker run --rm -it $(NAME) /bin/sh

run:
	docker run --rm -it -v ~/projects:/projects $(NAME) /bin/sh

build:
	docker build -t $(NAME) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .

push:
	docker push $(NAME)

release: build push

