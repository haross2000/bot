#!/bin/bash

# Install build dependencies
apt-get update
apt-get install -y wget build-essential

# Download and install TA-Lib
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xvzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
./configure --prefix=/usr
make
make install
cd ..
rm -rf ta-lib-0.4.0-src.tar.gz ta-lib/

# Install TA-Lib for Python
pip install TA-Lib
