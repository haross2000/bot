#!/bin/bash

# Update package list and install build dependencies
apt-get update
apt-get install -y build-essential wget

# Install TA-Lib
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
./configure --prefix=/usr
make
make install
cd ..
rm -rf ta-lib ta-lib-0.4.0-src.tar.gz

# Update pip
pip install --upgrade pip

# Install wheel
pip install wheel

# Install numpy with specific version range
pip install "numpy>=1.21.6,<1.28.0"

# Install pandas
pip install "pandas>=1.3.0"

# Install TA-Lib python wrapper
pip install TA-Lib==0.4.19

# Install the rest of the requirements
pip install -r requirements.txt
