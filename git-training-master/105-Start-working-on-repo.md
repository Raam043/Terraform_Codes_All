## We have two methods to start using github:
- First one is to create a repository online via Web gui , clone it to our local machine and start using it!
    - This is usally good when you are starting from scratch on a brand new repository / project !

- Second one is the time you have a project and its been a while you worked on it and now you want to put it also on github and managing it via git version control systems !



## lets try the first one :

now we need to clone from github site into our local drive 


[LAB]
- create a folder through linux on c drive and call git-repo:

    mkdir git-repo

    cd git-repo

    git clone "here copy the link from github site"
    
git status
 
git add . --all the files will be staged for commit

git status

git commit -m "write a meaasage regarding to change"

git status

You can do stage and commit in one shot with `commit -am "comment" `
 

this comand will commit the changes on our local drive

git log



#### If you'd like to push it to github then :

git push origin master -- this command will push the changes to the github

origin is actually your remote repository on github 


git config --list   >>  what is configuration setting




## Second method :

[LAB]
- On your local directory :
    - git init
    - Create something 
    - git add .
    - git commit -m "Message"
    - git remote add origin URL
    - git push -u origin master

### Diff
git diff ---> for unstaged ---> unstaged mean no ---> git add 

git diff --staged ---> for staged mean ---> after git add
