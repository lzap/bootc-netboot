# Anaconda PXE files for bootc

Distributing Anaconda installer, shim and bootloader via container registries.

## Usage

To pull Anaconda files:

    # oras pull ghcr.io/lzap/bootc-netboot-example:rhel-9.3.0-x86_64

The contents is:

    # ls
    vmlinuz
    initrd.img
    shim.efi
    grubx64.efi

Before executing binaries, signature must be verified:

    # cosign verify --key cosign.pub ghcr.io/lzap/bootc-netboot-example:rhel-9.3.0-x86_64

## Publish

Login to the registry:

    # oras login ghcr.io

The example will use the following environment variables:

    ARTIFACT_TYPE=application/vnd.unknown.artifact.v1
    MEDIA_TYPE=application/x-netboot-file

Upload new artifacts:

    # pushd rhel-9.3.0-x86_64
    # oras push ghcr.io/lzap/bootc-netboot-example:rhel-9.3.0-x86_64 \
        --annotation-file ../annotations.json \
        --config ../empty.json:application/vnd.oci.empty.v1+json \
        --artifact-type $ARTIFACT_TYPE vmlinuz:$MEDIA_TYPE initrd.img:$MEDIA_TYPE
    # popd

Sign the artifacts:

    # cosign sign --key cosign.key -y ghcr.io/lzap/bootc-netboot-example:rhel-9.3.0-x86_64

That is all.
