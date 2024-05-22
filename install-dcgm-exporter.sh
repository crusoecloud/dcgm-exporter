#!/bin/bash

# Update package list and install dependencies
sudo apt-get update
sudo apt-get install -y wget tar datacenter-gpu-manager

# Define Go version
GO_VERSION=1.21.1

# Download Go binary
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz

# Remove any previous Go installation
sudo rm -rf /usr/local/go

# Extract Go binary
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# Remove downloaded tarball
rm go${GO_VERSION}.linux-amd64.tar.gz

# Set up Go environment variables
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
echo "export GOPATH=\$HOME/go" >> ~/.profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.profile

# Apply environment variables to the current session
source ~/.profile

# Verify installation
go version


git clone https://github.com/NVIDIA/dcgm-exporter.git
cd dcgm-exporter
make binary
sudo DIST_DIR=cmd/dcgm-exporter PATH=$PATH:/usr/local/go/bin make install
