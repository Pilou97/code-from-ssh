# code-from-ssh

Start VSCode on Host machine from ssh session.

I tried WSL and I loved having a linux on my windows. I liked the feature of vscode which allows you to start vscode on windows from wsl. Unfortunately, I need a real distro for my work. 
I am using a virtual machine but vscode doesn't give you the ability to start vscode from the computer where you are accessing the virtual machine. It can be from windows or from macos or from a linux distro

So I created this script.

/bin/zsh -c "export LC_VSCODE='/opt/homebrew/bin/code'; export LC_OS='macos'; export LC_USER='pilou'; ssh -p 2222 -R 8822:localhost:22 -o SendEnv=LC_OS -o SendEnv=LC_USER -o SendEnv=LC_VSCODE pilou@www.duboispl.com "

## VPS requirement:

Just install the file `code` in your path
Your vps must be a linux distro (works fine on debian)

## Requirement for uour personal computer

### Windows
    - openssh server
    - psexec
    - vscode installed for the all user (system installation)


### Macos
    - openssh server configured (see apple documentation)
    - vscode installed (I install mine via `brew`)

The two systems must know keys of each others.

For windows only, the linux system should know the key of system user (because vscode is run as system user, see known issues sections)

## Environments variable

You should provide some environment variable to your linux distro:
 - LC_VSCODE : the path to the vscode execution
 - LC_OS : the os of your computer, possible values are: 'macos', 'windows'
 - LC_USER: the user of your computer

## The script should be in your path (on your VPS)

For instance

```bash
$ cp code /usr/local/bin
```

## Tips to provide environment variables

If you use to connect to your vps via ssh you can provide environment variable via the following command:

windows:
```bash
powershell $env:LC_REVERSE_PORT=8822;$env:LC_OS=\"windows\";$env:LC_USER=\"windows_username\";$env:LC_VSCODE=\"C:\Program Files\Microsoft VS Code\Code.exe\";ssh -R \"$($env:LC_REVERSE_PORT):localhost:22\" -o SendEnv=LC_OS -o SendEnv=LC_USER -o SendEnv=LC_VSCODE -o SendEnv=LC_REVERSE_PORT -p 2222 vps@vps.com
```

macos:
```bash
/bin/zsh -c "export LC_REVERSE_PORT=8823; export LC_VSCODE='/opt/homebrew/bin/code'; export LC_OS='macos'; export LC_USER='your mac username'; ssh -R $LC_REVERSE_PORT:localhost:22 -o SendEnv=LC_OS -o SendEnv=LC_USER -o SendEnv=LC_VSCODE -o SendEnv=LC_REVERSE_PORT vps@vps.com"
```

I use this command when starting my terminal, so that I am directly in my linux instance


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

I had to use -s (run as system) on the psexec otherwise new windows (as open folder) is black; that's why you have to generate a system key pair.