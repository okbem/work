#!/bin/bash

BASE_DIR="$(dirname "$(readlink -f "$0")")"

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    >&2 echo "$0 must be run as root"
    exit 1
fi

# Change password for root
passwd || exit 1

# Update packages
apt update -y && apt dist-upgrade -y && apt autoremove -y && apt autoclean -y
apt install -y docker.io net-tools unzip || exit 1

# Configure ssh and sshd
cp -f "${BASE_DIR}"/etc/ssh/* /etc/ssh/ || exit 1
sed -Ei $'/Port 22/c\\\nPort 21322\n' /etc/ssh/sshd_config || exit 1
service ssh restart || exit 1
rm -rf /root/.ssh/ || exit 1

# Install AWS CLI
curl -fsS https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip || exit 1
unzip /tmp/awscliv2.zip -d /tmp/ || exit 1
/tmp/aws/install || exit 1
rm -rf /tmp/awscliv2.zip /tmp/aws/ || exit 1

# Reboot
shutdown -r now

# Run the following commands after log in as root
# deluser --remove-home ubuntu
# adduser --gecos '' jbpark
# usermod -aG docker jbpark

