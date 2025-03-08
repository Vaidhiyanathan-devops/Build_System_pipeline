#!/bin/bash

# Variables
SRC_DIR="/tmp/packages"
NODE_VERSION="22.13.1"
INSTALL_PATH="/opt/zoho/nodejs22.13"
TAR_OUTPUT="/tmp/nodejs-${NODE_VERSION}.tar.gz"

# Step 1: Extract the source tarball
cd "$SRC_DIR" || exit
tar -xvf node-v${NODE_VERSION}.tar.gz

# Step 2: Change to extracted directory
cd "node-v${NODE_VERSION}" || exit

# Step 3: Configure for custom location (but no install)
./configure --prefix=${INSTALL_PATH} --enable-optimization

# Step 4: Compile (without installing)
make -j$(nproc)

# Step 5: Package compiled binaries into tar.gz
tar -czvf ${TAR_OUTPUT} -C out .

echo "Node.js ${NODE_VERSION} compiled successfully and stored at ${TAR_OUTPUT}"

