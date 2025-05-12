#!/bin/bash
set -ouex pipefail

# Install extra packages
dnf5 install -y tmux

# Enable systemd services
systemctl enable podman.socket

# Add the Linux Surface repo
curl -o /etc/yum.repos.d/linux-surface.repo https://pkg.repo.linuxsurface.com/fedora/l>

# Replace the default Fedora kernel with Linux Surface kernel
rpm-ostree override remove \
  kernel \
  kernel-core \
  kernel-modules \
  kernel-modules-extra \
  libwacom \
  libwacom-data

rpm-ostree install \
  kernel-surface \
  iptsd \
  libwacom-surface \
  libwacom-surface-data
