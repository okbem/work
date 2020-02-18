#!/bin/sh

exec docker container run \
    -d -it \
    --network host \
    --restart unless-stopped \
    --log-driver none \
    --name "${1:-work}" \
    work

