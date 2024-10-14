#!/bin/bash

# Function to install OpenSSL and development packages
install_openssl() {
    if [ -f /etc/arch-release ]; then
        # Arch Linux
        sudo pacman -Sy --noconfirm openssl openssl-1.1
    elif [ -f /etc/debian_version ]; then
        if [ -f /etc/lsb-release ] && grep -q "Ubuntu" /etc/lsb-release; then
            # Ubuntu
            sudo apt-get update
            sudo apt-get install -y pkg-config libssl-dev
        else
            # Debian
            sudo apt-get update
            sudo apt-get install -y pkg-config libssl-dev
        fi
    elif [ -f /etc/fedora-release ]; then
        # Fedora
        sudo dnf install -y openssl openssl-devel
    elif [ -f /etc/redhat-release ]; then
        # CentOS/RHEL
        if command -v dnf &> /dev/null; then
            # Use DNF if available (CentOS 8+, RHEL 8+)
            sudo dnf install -y openssl openssl-devel
        else
            # Fall back to YUM for older versions
            sudo yum install -y openssl openssl-devel
        fi
    elif [ -f /etc/alpine-release ]; then
        # Alpine Linux
        sudo apk add --no-cache openssl openssl-dev
    elif [ -f /etc/SuSE-release ] || [ -f /etc/os-release ] && grep -q "ID=opensuse" /etc/os-release; then
        # openSUSE
        sudo zypper install -y openssl openssl-devel
    else
        echo "Unsupported distribution"
        exit 1
    fi
}

# Main script
echo "Installing OpenSSL and development packages..."
install_openssl

if [ $? -eq 0 ]; then
    echo "OpenSSL and development packages installed successfully"
else
    echo "Failed to install OpenSSL and development packages"
    exit 1
fi

# Verify installation
openssl version

exit 0