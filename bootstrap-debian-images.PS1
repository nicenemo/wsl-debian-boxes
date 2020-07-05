#!/usr/bin/env pwsh
#
#Get Standard Debian (Stretch?) from Windows store and install
#
$url = "https://aka.ms/wsl-debian-gnulinux"
$output = "debian.appx"
echo "Getting Debian WSL image from Microsoft."
Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output
echo "Installing image."
Add-AppxPackage .\debian.appx

# Do post install without creating a user.
echo "Performing post install."
debian install --root

# Created Updated Stretch image.
echo "Set Stretch package sources."
debian run cp ./files/stretch_sources.list /etc/apt/sources.list
echo "Updating and upgrading packages."
debian run ./upgrade-packages.sh
echo "Creating debian-stretch.tar tarball."
wsl --export Debian debian-stretch.tar

# Create Buster image from Stretch.
echo "Set Buster package sources."
debian run cp ./files/buster_sources.list /etc/apt/sources.list
echo "Perform distribution upgrade from Stretch to Buster."
debian run ./upgrade-distro.sh
echo "Creating debian-buster.tar tarball."
wsl --export Debian debian-buster.tar

# Create Bullseye image from Buster.
echo "Set Bullseye package sources."
debian run cp ./files/bullseye_sources.list /etc/apt/sources.list
echo "Perform distribution upgrade from Buster to Bullseye."
debian run ./upgrade-distro.sh
echo "Creating debian-bullseye.tar tarball."
wsl --export Debian debian-bullseye.tar

# Clean up standard Debian image
wsl --terminate Debian
wsl --unregister Debian
Get-AppxPackage -name TheDebianProject.DebianGNULinux|Remove-AppPackage
rm debian.appx
