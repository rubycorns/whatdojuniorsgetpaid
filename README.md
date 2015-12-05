# whatdojuniorsgetpaid [![Build Status](https://travis-ci.org/rubycorns/whatdojuniorsgetpaid.svg?branch=master)](https://travis-ci.org/rubycorns/whatdojuniorsgetpaid)

Anonymously share your salary stories, and help others to learn from your experiences.

ruby version 2.2.2

rails version 4.2.3

### Get the code

Get the code from this repo

    git clone

### Run locally

Install all the gems

    bundle install

Spice up the database

    rake db:migrate

Get some data

    rake db:seed

Run the server

    rails s

et voilá

## Contributing

Please contribute! Fix typos, submit issues, make PRs! We welcome everything. 

### Git: branches 
*Note*: you will need permission from the rubycorns in order to push your branches to this repository. 
Until you have been granted permission, please [fork](https://help.github.com/articles/fork-a-repo/) this repository, 
and create a branch from your fork.  

Create new branch (you should be in the directory of the project) 
    
    git branch Name_of_your_branch
    
Switch to the newly created branch (the same if you need to change to the branch that already exist) 
    
    git checkout Name_of_your_branch

Or for lazy people (does both steps at the same time):
    
    git checkout -b Name_of_your_branch    

Push the new branch to the repository (with some commits or just "bare" branch) 
    
    git push --set-upstream origin Name_of_your_branch
    
Delete local branch

    git branch -D Name_of_your_branch
    
    
### Git: commit your changes
Make changes, then 
    
    git add -A

Tell the others what you did
    
    git commit -m "description of changes"

Off to GitHub
    
    git push
    
### Make a pull request
1. Select your branch on GitHub.
2. Click 'Pull Request'.
3. Write a little summary of what you did and alert people if you need help.
before merging.
4. When you merge and close your branch, please make sure to include a [ridiculous gif](https://github.com/rubycorns/RailsGirlsApp/pull/281#issuecomment-64454385). 
