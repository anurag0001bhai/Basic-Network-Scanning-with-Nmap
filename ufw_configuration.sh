#!/bin/bash
# ============================================================
# ufw_configuration.sh
# Task 2 — Basic Firewall Configuration with UFW
#
# This script installs (if needed) and configures UFW with a
# baseline set of rules. Run with: sudo ./ufw_configuration.sh
# ============================================================

set -e

echo "[1/7] Installing UFW (if not already installed)..."
sudo apt update -y
sudo apt install ufw -y

echo "[2/7] Setting default policies (deny incoming, allow outgoing)..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[3/7] Allowing SSH traffic (port 22)..."
sudo ufw allow ssh

echo "[4/7] Denying HTTP traffic (port 80)..."
sudo ufw deny http

echo "[5/7] Allowing HTTPS traffic (port 443)..."
sudo ufw allow https

echo "[6/7] Denying traffic from a specific untrusted IP range..."
# Example range — replace with the actual range you want to block
sudo ufw deny from 203.0.113.0/24

echo "[7/7] Enabling UFW..."
sudo ufw --force enable

echo ""
echo "Current UFW status:"
sudo ufw status verbose
