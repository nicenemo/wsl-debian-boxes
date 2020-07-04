# Automatically generated WSL Debian development environments

This project enables you to quickly create up to date WSL2 Debian instances for testing and development purposes.
For this you need Windows 10 and hardware that is capable of running WSL2.

To use this create a directory `c:\wsl` where you have write rights. This is used to store your machine's disk images.

Next clone or get started download this project.
In Powershell navigate to the project.

```cmd
PS C:\Users\Hans Kruse> git clone https://github.com/nicenemo/wsl-debian-boxes
PS C:\Users\Hans Kruse> cd wsl-debian-boxes
PS C:\Users\Hans Kruse\wsl-debian-boxes>
```

Start [bootstrap-debian-images.PS1](bootstrap-debian-images.PS1) to create local updated, tar ball, machines images for Debian:
* 9 Stretch
* 10 Buster
* 11 BullsEye

**Warning!** You should not run the script below if you use the Debian distribution from the Windows store direcyly as your personal WSL environment. It will be destroyed!.

```cmd
PS C:\Users\Hans Kruse\wsl-debian-boxes> bootstrap-debian-images.PS1
```
When succesfull 3 tar balls have been created. The Debian machine was deleted and also the downloaded Debian Installation package was deleted. Also the installed Windows store app was uninstalled.

Once you have created the tar balls, creating new machines is quite fast. Faster than installing them from the Windows store. It also allows you to easily create multiple identical machines with the same Linux distribution.


Machines can be created and personalized with the [create-machine.PS1](create-machine.PS1) script.

* A user is created with sudo rights without needing a password.
* In the user's home directory a soft link _winhome_ to the windows home directory of the user is created.
* The created machines will start with the created user as default user.
* An updated ansible is installed in the user's ~/.local/bin.
* ~/.local/bin is added to the user's path.
* No furter customization is done yet.

Two user environment variables need to be set before you can create machines with the provided script.

* *LINUX_USER* Should be the Linux username of the single user that is created in the machine, e.g. *kruse*.
* *WIN_HOME* Should be a windows  directory as seen from Linux. This will be softlinked as *winhome* in the Linux user's home directory, e.g. */mnt/c/Users/Hans\ Kruse*. Note that spaces need to be escaped!

you can then give a name of the machine to be created and the tar ball to use as command line arguments.

```cmd
PS C:\Users\Hans Kruse\wsl-debian-boxes> create-machine.PS1 my-awesome-box debian-buster.tar
```
Cleaning up machines can be done with the [destroy-machine.PS1](destroy-machine.PS1) script.

```cmd
PS C:\Users\Hans Kruse\wsl-debian-boxes> destroy-machine.PS1 my-awesome-box
```

In the _files_ directory, you will find the Debian package sources files that are used.
You can modify them to use a local mirror. That might be faster than pulling them from the main debian archives directly.

## Beware of smart git on Windows!

Windows on git by default converts line endings to/from Linux/Windows.
This will go horribly wrong if you edit the bash files from Windows. Either use git from WSL and edit files from WSL. Or turn of line ending conversion on git in WIndows.
Bash files with Windows line endings do not run.
