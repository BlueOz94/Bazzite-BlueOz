#!/bin/bash
set -ouex pipefail

### Install extra packages
dnf5 install -y tmux

### Enable systemd services
systemctl enable podman.socket

### Add Surface kernel support

# Remove Fedora's default kernel and libwacom
rpm-ostree override remove \
  kernel \
  kernel-core \
  kernel-modules \
  kernel-modules-extra \
  libwacom \
  libwacom-data

# Add the Linux Surface repository
cat > /etc/yum.repos.d/linux-surface.repo << EOF
[linux-surface]
name=Linux Surface Kernel
baseurl=https://pkg.repo.linuxsurface.com/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://pkg.repo.linuxsurface.com/keys/3DFA4A0333A3D3B3.gpg
EOF

# Install Surface kernel and related packages
dnf5 install -y \
  kernel-surface \
  iptsd \
  libwacom-surface \
  libwacom-surface-data
