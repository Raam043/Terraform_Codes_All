# Understanding the Github branches flow

[There is a good explanation here](https://guides.github.com/introduction/flow/)

### In a nutshell:
>- Create a branch
>- Add commits
>- Open a pull request
>- Discuss and review your code
>- merge 

In Previous session we commit codes to our project or lets say master branch???? !

Generally the best approach to work with git is via branches !
Of course you can commit your code to master (Main / Production) branch but for avoid any mistakes and issues i highly recommend you to create branch and start working on your branch , you may say Ok , but what is a branch ?!

## Branch is like a complete copy of your project completely isolated ! like a sandbox ?!

# Create a branch:
When you create a branch in your project, you're creating an environment where you can try out new ideas. Changes you make on a branch don't affect the `master` branch, so you're free to experiment and commit changes, safe in the knowledge that your branch won't be merged until it's ready to be reviewed by someone you're collaborating with.

## _In most of real life scenarios you can't directly push any commit toward master branch ! it must be via branch creation !_


## ProTip:
Branching is a core concept in Git, and the entire GitHub flow is based upon it. There's only one rule: anything in the master branch is always deployable.

Because of this, it's extremely important that your new branch is created off of master when working on a feature or a fix. Your branch name should be descriptive (e.g., refactor-authentication, user-content-cache-key, make-retina-avatars), so that others can see what is being worked on.

[LAB]:

See list of branch and the active one with an astrisk (*) on the left:

    git branch

Create your branch :

    git branch [brach name]

Switch to the newly created branch :

    git checkout [branch name]

Do it in one shot! create a branch and switch to it :

    git checkout -b [Branch name]




# Add commits:

Do changes in the new branch environment and commit your code!
You are basically creating a transparent history of your work in the newly created branch isolated from master branch so do whatever you want and commit your code!

[LAB]
### After changes you need to push your branch to github :

>run `git push origin <Name of your branch>` in the newly created branch!


# Pull request:

Create a pull request to propose and collaborate on changes to a repository. These changes are proposed in a branch, which ensures that the `master` branch only contains finished and approved work.

[LAB]:

If you check github repository now , you can see new branch in Web GUI and you can easily Click on `Compare & Pull request`

You can put see changes and compare them with master or any other branches you can comments and mention other team members to review your code, basically they can see all the modifications and all the changed files!

[For more help click here](https://help.github.com/en/articles/creating-a-pull-request)

You can configure continuous integration but for now we are just going to stick with default settings!

Once you've created a pull request, you can push commits from your topic branch to add them to your existing pull request. These commits will appear in chronological order within your pull request and the changes will be visible in the "Files changed" tab.

Other contributors can review your proposed changes, add review comments, contribute to the pull request discussion, and even add commits to the pull request.

# Merge:

After you're happy with the proposed changes, you can merge the pull request. If you're working in a shared repository model, the proposed changes will be merged from the head branch to the base branch that was specified in the pull request.


# Pull

git branch -a

git pull <remote> <branch>

# Push

git push <remote> branch

# Delete 

List all branches
------------------
git branch -a

Executive Summary
-------------------
git push -d <remote_name> <branch_name>
git branch -d <branch_name>

Note that in most cases the remote name is origin. In such a case you'll have to use the command like so.
---------------------------------------------------------------------------------------------------------

git push -d origin <branch_name>

