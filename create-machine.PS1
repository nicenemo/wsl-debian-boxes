

#
# Sets the default user of a distribution.
#
# Usage:
# WSL-SetDefaultUser <DistroName> <UserName>
#
# Example:
#
# WSL-SetDefaultUser Debian-10 kruse
#
# This standard wsl command does not offer the option to set the default user like distribution specific starter programs do.
#
# Stolen from https://github.com/microsoft/WSL/issues/3974
Function WSL-SetDefaultUser ($distro, $user) { Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\*\ DistributionName | Where-Object -Property DistributionName -eq $distro | Set-ItemProperty -Name DefaultUid -Value ((wsl -d $distro -u $user -e id -u) | Out-String); };

#
# The linux username you want to use for your machine.
# Set it in your user environment variables.
#
$env:LINUX_USER=[System.Environment]::GetEnvironmentVariable('LINUX_USER','user')

#
# The location of your Windows home directory as seen from Linux. Note that spaces need to be escaped!.
# E.g.: My home directory on windows is: "C:\Users\Hans Kruse".
# On Linux this WIN_HOME becoes "/mnt/c/Users/Hans\ Kruse"
# We create a win_home soft link in your linux home directory.
#
$env:WIN_HOME=[System.Environment]::GetEnvironmentVariable('WIN_HOME','user')

#
# Imports the machine from a tar ball.
# First argument is the name of your box, second the file name of the tar bar in the current directory.
#
wsl --import $args[0] c:\wsl\$args[0] $args[1]

#
# Upgrade the created machine first.
# It might have been a while since the tar ball was created.
#
echo "Update packages"
wsl -d $args[0] ./upgrade-packages.sh

#
# Install python and pip.
# Since further customization is intended to be done with Ansible we need this.
# These are installed from Debian apt-repos.
# A further update is done from within the user account, creating versions specific to the user.
echo "Install python3 and pip"
wsl -d $args[0] sudo apt-get -y install python3 python3-pip python3-apt aptitude

#
# Create the user with password less sudo right.
#
echo "Create user with password-less sudo rights."
wsl -d $args[0] ./personalize.sh $env:LINUX_USER $env:WIN_HOME
echo "Set default user."
WSL-SetDefaultUser $args[0]  $env:LINUX_USER
#
# Install a possible upgraded pip in the users .local/bin
# Then install install ansible.
#
wsl -d $args[0] python3 -m pip install pip --upgrade
wsl -d $args[0] python3 -m pip install ansible

#
# Remove created function
Remove-Item Function:WSL-SetDefaultUser
