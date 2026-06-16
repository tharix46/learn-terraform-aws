#!/bin/bash
# Update package repositories
apt update -y

# Install Nginx
apt install nginx -y

# Start and enable Nginx to run on boot
systemctl start nginx
systemctl enable nginx