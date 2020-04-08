include common.mk

all: image

image:
	docker build -f ${XVCFMERGE_HOME}/Dockerfile --build-arg XVCFMERGE_USER -t $(XVCFMERGE_IMAGE_NAME) .

image-force:
	docker build --no-cache -f ${XVCFMERGE_HOME}/Dockerfile --build-arg XVCFMERGE_USER -t $(XVCFMERGE_IMAGE_NAME) .

publish: image
	docker push $(XVCFMERGE_IMAGE_NAME)

prune:
	docker container prune -f
	docker image prune -f

.PHONY: image publish prune
