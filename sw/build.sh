#!/usr/bin/bash
runner=docker
if ! [ -x "$(command -v docker)" ]; then
	runner=podman
fi
$runner run --rm -v `pwd`:/sw -w /sw --name snitch_build ghcr.io/pulp-platform/snitch /bin/bash build_internal.sh $1
