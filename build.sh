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

# Install numpy first
pip install numpy==1.19.5

# Install pandas
pip install pandas==1.3.0

# Install TA-Lib python wrapper
pip install TA-Lib==0.4.19

# Install the rest of the requirements
pip install -r requirements.txt
