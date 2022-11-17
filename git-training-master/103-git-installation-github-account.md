# Install git:

Go to [Git download page](https://git-scm.com/downloads) and follow the steps for installing git on your workstation

# Open github account:

go to https://github.com and signup for a free account 

[Git setup help](https://help.github.com/en/articles/signing-up-for-a-new-github-account)

# Git setup on your workstation :

 - windows 10 & Ubuntu :
      
    [My suggestion is install windows linux subsystem (wsl)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
    
    in this case you basically have a Ubuntu shell in windows to work with and you can easily install git :
    
    `sudo apt-get install git -y`
    
# Installing *Git* on a *Mac*



## Step 1 – Install [*Homebrew*](http://brew.sh/)

> *Homebrew* […] simplifies the installation of software on the Mac OS X operating system.



**Copy & paste the following** into the terminal window and **hit `Return`**.

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
```

You will be offered to install the *Command Line Developer Tools* from *Apple*. **Confirm by clicking *Install***. After the installation finished, continue installing *Homebrew* by **hitting `Return`** again.

## Step 2 – Install *Git*

**Copy & paste the following** into the terminal window and **hit `Return`**.

```shell
brew install git
```

**You can use *Git* now.**


# Note : Each folder / project in github echo systems is called repository !

## First-time setup :

    You need to run:
`git config --global user.name "Example John Doe"`

`git config --global user.email johndoe@example.com`
    
    this is gonna set a user globally for all of your folders / projects / repositories 

## note : global means your current user in the systems

#### You can overwrite user for each repository we talk about it later 

# How git config works :
   
 
Git comes with a tool called git config that lets you get and set configuration variables that control all aspects of how Git looks and operates. These variables can be stored in three different places:
    
- /etc/gitconfig file: Contains values for every user on the system and all their repositories. If you pass the option--system to git config, it reads and writes from this file specifically.
        
- ~/.gitconfig file: Specific to your user. You can make Git read and write to this file specifically by passing the --global option.
        
- config file in the Git directory (that is, .git/config) of whatever repository you’re currently using: Specific to that single repository. Each level overrides values in the previous level, so values in .git/config trump those in /etc/gitconfig.
        

On Windows systems, Git looks for the .gitconfig file in the $HOME directory (%USERPROFILE% in Windows’ environment), which is C:\Documents and Settings\$USER or C:\Users\$USER for most people, depending on version ($USER is %USERNAME% in Windows’ environment). It also still looks for /etc/gitconfig, although it’s relative to the MSys root, which is wherever you decide to install Git on your Windows system when you run the installer.
    
## Checking your settings :

If you want to check your settings, you can use the git config --list command to list all the settings Git can find at that point:

    git config --list
    user.name=Scott Chacon
    user.email=schacon@gmail.com
    color.status=auto
    color.branch=auto
    color.interactive=auto
    color.diff=auto
    user.name=ITrepo01
    user.email=ITrepo01@gmail.com
    ...



    
You may see keys more than once, because Git reads the same key from different files (/etc/gitconfig and ~/.gitconfig, for example). In this case, Git uses the last value for each unique key it sees.

You can also check what Git thinks a specific key’s value is by typing git config {key}:

_git config user.name_

_Scott Chacon_
