#!/usr/bin/env pwsh

#
# The location where you want to install your Linux distributions.
# E.g.: c:\WSL
# By default Windows will install your linux distributions in your APP_DATA
# folder in your home directory. My Linux distributions tend to grow large. I
# prefer them to be somewhere else, if possible on another disk.
#
$env:WSL_INSTAL_PATH=[System.Environment]::GetEnvironmentVariable('WSL_INSTAL_PATH','user')

wsl --terminate $args[0]
wsl --unregister $args[0]
rm -r -fo $env:WSL_INSTAL_PATH\$args[0]
