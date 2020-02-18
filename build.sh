#!/bin/sh

exec docker image build \
    -t work \
    "$(dirname "$(readlink -f "$0")")"

