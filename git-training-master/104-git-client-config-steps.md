### Side notes :

~ means home directory and you can use `cd ~`  to go to home directory in Linux environments

. In Linux if file or directory are starting with a dot , it means that object is hidden

## For authentication Instead of password we are using public and private keys , to see if we have key on the machine do the below cmd

#### Lets check if we already have the SSH keys 

Linux :

    cat ~/.ssh/id_rsa.pub 

Windows :

    Open cmd and type type %userprofile%\.ssh\id_rsa.pub
 

### (This are the places you can find the public key usually if there is any !)

If not we need to generate a key 

    ssh-keygen -t rsa -b 4096 -C "<Your Email>@gmail.com"

-c is for adding comment for ourself to show that this key is for this email/user

now we generated a key so we need to add the public key into the github

cd ~
cd .ssh
ls -lah
cat id-rsa.pub

basically `id-rsa.pub` is the public key , or you need to use whatever name you used during key generation!


copy the key and paste into github site

## Note: If you are using windows there'll be an .ssh folder in your user profile directory which contain your Public and private keys.

