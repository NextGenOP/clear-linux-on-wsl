*Clear Linux on WSL*
=====================

This repository provides a script to automate the installation of Clear Linux on Windows Subsystem for Linux (WSL).

**Installation**
---------------
***Automated Installation***
To install Clear Linux on WSL, follow these steps:

1. Run the `install-clear-linux.ps1` script from this repository to automate the installation process.
2. Once the installation is complete, open Clear Linux and perform [post-installation setup](#post-install).

***Manual Installation***

Alternatively, you can install Clear Linux manually by following these steps:

1. Ensure WSL is enabled in the Windows Features.
2. Download the release file and place it in `C:\wsl_distros\sources`.
3. Run `wsl --update`.
4. Run `wsl --import ClearLinux C:\wsl_distros\ClearLinux C:\wsl_distros\sources\clear_linux_rootfs.tar.zst --version 2`.
5. Run `wsl --list --verbose` to see if Clear Linux is successfully installed.
6. Once the installation is complete, open Clear Linux and perform [post-installation setup](#post-install).

<a name="post-install">
**Post-Installation Setup** 
</a>
---------------

### 1. Update the System

```sh
swupd update
```

### 2. Create a New User

```sh
useradd -m -s /bin/bash <YOURUSERNAME>
passwd <YOURUSERNAME>
```

Replace \<YOURUSERNAME> with your actual username.

### 3. Add Basic Bundles

```sh
swupd bundle-add sysadmin-basic sudo
```

### 4. Add User to Sudoers

```sh
usermod -aG wheel <YOURUSERNAME>
```

Replace \<YOURUSERNAME> with your actual username.

### 5. Configure WSL.conf

```sh
cat >> /etc/wsl.conf << 'EOF'
[automount]
enabled = true
options = "metadata,uid=1000,gid=1000,umask=22,fmask=11,case=off"
mountFsTab = true
crossDistro = true

[network]
generateHosts = true
generateResolvConf = true

[interop]
enabled = true
appendWindowsPath = true

[user]
default = <YOURUSERNAME>

'EOF'
```

Replace \<YOURUSERNAME> with your actual username.

**Additional Steps**
---
### 1. Create Shortcut
Create new shortcut with this command
```
wsl -d ClearLinux -u <YOURUSERNAME> -w ~
```
Replace \<YOURUSERNAME> with your actual username.
Set the icon with this [icon](https://raw.githubusercontent.com/gh0st-work/clear-linux-wsl/main/clear_linux_logo.ico)
### 2. Pin to taskbar

**Credits**
---
[Clear Linux](https://www.clearlinux.org/)
[gh0st-work/clear-linux-wsl](https://github.com/gh0st-work/clear-linux-wsl)
