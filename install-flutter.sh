#!/bin/bash

# Download Flutter SDK
echo "Downloading Flutter SDK..."
curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.0-stable.tar.xz

# Extract Flutter SDK
echo "Extracting Flutter SDK..."
tar xf flutter.tar.xz

# Add Flutter to PATH
echo "Adding Flutter to PATH..."
export PATH="$PATH:$PWD/flutter/bin"

# Verify Flutter installation
echo "Checking Flutter installation..."
flutter doctor

# Print Flutter version (for debugging purposes)
flutter --version
