#!/usr/bin/bash
/usr/bin/podman run --rm -v `pwd`:/sw -w /sw --name snitch_build ghcr.io/pulp-platform/snitch /bin/bash build_internal.sh $1
