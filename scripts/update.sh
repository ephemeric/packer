#!/bin/bash

set -ueo pipefail

while [ ! -f /var/lib/cloud/instance/boot-finished ]; do sleep 5; done

echo "Hello."

exit 0
