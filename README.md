# code-from-ssh

Start VSCode on Host machine from ssh session.

I tried WSL and I loved having a linux on my windows. I liked the feature of vscode which allows you to start vscode on windows from wsl. Unfortunately, I need a real distro for my work. 
I am using a virtual machine but vscode doesn't give you the ability to start vscode on windows from an ssh session.

So I created this script.

## Host Requirement:
    - windows
    - openssh server
    - psexec 
    - vscode is installed for the system

## Guest Requirement
    - openssh

The two systems must know keys of each others.
And the linux system should know the key of system user (because vscode is run as system user, see known issues sections)

## Environments variable

 - GUEST_ADDR : the ip address (or domain name) of your linux machine (in my case it's a local ip)
 - GUEST_USER: the username of your linux user
 - HOST_USER: the username of your windows user where vscode should run
 - HOST_IP: the ip of the host (in my case it's my local ip)
 - HOST_VSCODE_PATH: the path where Code.exe is installed

## The script should be in your path (in the guest machine)

For instance

```bash
$ cp code /usr/local/bin
```

## How to use:

```bash
$ code . # Will open code in windows, and open with remote-ssh the current folder in your virtual machine
```

You can specify an absolute path too
```bash
$ code /home/user/Documents
```

Or without any argument (which is the same as `code .`)

## Known Issues

I had to use -s (run as system) on the psexec otherwise new windows (as open folder) is black; that's why you have to generate key via system.

