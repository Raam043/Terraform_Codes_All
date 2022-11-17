# Managing commit signature verification

If you are dealing with commits that are not signed then :

someone may have pushed to your repository claiming to be you. Or for that matter, someone could have pushed to someone else's repository claiming to be you (someone could push to their own repository claiming to be you too).

With signing of the commits (and tags), one can prove that certain commits and tags were from you (and things that aren't signed shouldn't have made it into the production build). That's really the key to it all—by signing commits you've said it's your work.>


# Steps for configuring commit signature verification:

- Install gpg on your box
>- run `gpg --full-generate-key`
>- run `gpg --list-secret-keys --keyid-format LONG`
>- run `gpg --armor --export <id of your key from above command>`
And copy paste it to your github account !

## Go to your repo :

>run `git config commit.gpgSign true`

>run `git config user.signingkey <key id>`

    

# Error in WLS (Windows 10) :

` error: gpg failed to sign the data
fatal: failed to write commit object`

use below :

    export GPG_TTY=$(tty)

And for make it permanetnt you can add it to your profile :
    vi ~/.bashrc


[More information](https://help.github.com/en/articles/managing-commit-signature-verification)

RESOURCE : https://zacharyvoase.com/2009/08/20/openpgp/



**Help**  :

https://www.youtube.com/user/GitHubGuides