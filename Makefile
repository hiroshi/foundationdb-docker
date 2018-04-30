IMAGE = hiroshi/foundationdb:5.1.5-1_ubuntu-16.04
build:
	docker build . -t $(IMAGE) -t fdb

push:
	docker push $(IMAGE)
