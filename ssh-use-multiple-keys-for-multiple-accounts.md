# Creating multiple github account:
lets assume that you have a personal github account and you've just got hired in a new company and now you hav also a corporate account!
You have plan to use both of them at the same time.

**Remember:** We configured `user.name` and `user.email` with `git config` command and now we have another username and Email to work with!
And you are also familiar with `config` concept !


## Create multiple ssh keys for each account:
Make sure that you are not overwriting any keys (use different names)
 >ssh-keygen -t rsa -b 4096 -f ~/.ssh/github-otheruser

## Create a config file :
$ (umask 077; touch ~/.ssh/config)

with below content


        Host github.com
          User git
          IdentityFile ~/.ssh/github-mainuser
        
        Host github.com-otheruser
          HostName github.com
          User git
          IdentityFile ~/.ssh/github-otheruser


Import your public key in github accounts respectively 

Create a repo and map it with your local repo :

     cd ~
     mkdir somerepo
     cd somerepo
     git init
Now configure this repo to use your identity

     git config user.name "Mister Manager"
     git config user.email "someuser@some.org"
Now make your first commit

     echo "hello world" > readme
     git add .
     git commit -m "first commit"

Check git log to make sure its using your correct email account !
    git log
    

and add the remote :
    git remote add origin github.com-otheruser:someuser/somerepo.git

## Note: For remote, We used the address that we configured it in `~/.ssh/config` file!


[resource](https://stackoverflow.com/questions/3860112/multiple-github-accounts-on-the-same-computer)
