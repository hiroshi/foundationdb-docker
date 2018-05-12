IMAGE = hiroshi3110/foundationdb:5.1.7-1_ubuntu-16.04
build:
	docker build . -t $(IMAGE) -t fdb

push:
	docker push $(IMAGE)
