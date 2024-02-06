#!/bin/bash -x
#
# Authentication:
# 	oras login ghcr.io (github username, github personal classic token as password)
#

REGISTRY=ghcr.io/lzap/bootc-netboot-example
ARTIFACT_TYPE=application/vnd.unknown.artifact.v1
#ARTIFACT_TYPE=application/x-netboot-images
MEDIA_TYPE=application/x-netboot-file

TAG=rhel-9.3.0-x86_64
pushd $TAG
oras push $REGISTRY:$TAG --annotation-file ../annotations.json \
	--config ../empty.json:application/vnd.oci.empty.v1+json \
	--artifact-type $ARTIFACT_TYPE \
	vmlinuz:$MEDIA_TYPE \
	initrd.img:$MEDIA_TYPE \
	shim.efi:$MEDIA_TYPE \
	grubx64.efi:$MEDIA_TYPE
popd

TAG=rhel-9.3.0-aarch64
pushd $TAG
oras push $REGISTRY:$TAG --annotation-file ../annotations.json \
	--config ../empty.json:application/vnd.oci.empty.v1+json \
	--artifact-type $ARTIFACT_TYPE \
	vmlinuz:$MEDIA_TYPE \
	initrd.img:$MEDIA_TYPE \
	shim.efi:$MEDIA_TYPE \
	grubaa64.efi:$MEDIA_TYPE
popd
