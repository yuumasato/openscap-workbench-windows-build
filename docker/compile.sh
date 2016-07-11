#!/bin/bash
IMGID=temp/scap-workbench-compile
docker build -t "$IMGID" $(dirname "$0") && {
	CID=$(docker create "$IMGID" /bin/bash)
	$(ls -A ./build > /dev/null) || {
		echo "./build is not empty dir! Cannot continue"
		exit 1
	}
	docker cp "$CID:/scap-workbench-build" ./build
	docker rm -f "$CID"
	docker rmi -f "$IMGID"
	echo ""
	echo "Build files are in "$(realpath ./build)""
	exit 0
}
exit 1
