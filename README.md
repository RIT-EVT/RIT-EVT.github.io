# RIT-EVT.github.io
Its our Website!
Official website for Rochester Institute of Technology Electric Vehicle Team

Installing depdencies:
```sh
sudo apt-get install ruby-dev
sudo gem install jekyll jekyll-paginate
```

Build the site:
```sh
jekyll build
```

You can alternatively use jekyll to serve the site locally without having to push it to GitHub:
```sh
jekyll serve
```

http://evt.rit.edu

# Contributing
This repository utilizes a pretty regimented development workflow to facilitate easy website deployment. 
Notable branches:
 - `master`: this branch is what is served by Github. Do not EVER commit to, branch off of, or do ANYTHING ELSE unless you have contacted @wheelerlaw first. 
 - `develop`: this branch is the "master" branch of the repo. The latest and greatest source code lives here. Jenkins uses this branch to build the site and sticks the built files into `master`. Branch off of this branch when creating your feature branch, but DO NOT create a PR against this branch. Read on for more information as to why.
 - `dmz`: This is the branch against which you will create pull requests. Jenkins automatically listens for changes to this branch. Jenkins merges this branch into develop, builds the site, and deploys it. 


Before you clone the repository, there are some settings you should set:
```
git config --global push.default current
git config --global core.autocrlf input
git config --global user.name "<insert your name here>"
git config --global user.email "<add your email address you use to sign into GH here"
```

To get started developing, first clone the repo if you have not already done so:
```
git clone https://github.com/RIT-EVT/RIT-EVT.github.io.git
cd RIT-EVT.github.io
```

If you have just cloned the repo, you can probably skip this next step. Otherwise, checkout `develop` and pull the latest changes:
```
git checkout develop
git pull
```

Create your feature branch off of `develop`. There is no enforced naming convention for feature branches, but most branch names are all lower case with words separated by underscores. PLEASE PLEASE PLEASE make it descriptive as to what the feature is (please).
```
git checkout -b your_feature_branch
```

Build (and serve up) the website locally and navigate to http://localhost:4000/ to view your changes before you push them.
```
jekyll serve
```

Now commit your changes and push them:
```
git add -A
git commit -m "Add some human readable, descriptive commit message."
git push -u 
```
Note: `-u` is only needed on the `git push` if the branch does not exist in `origin` (the repo in Github). 

Now, go to Github and create a pull request for you branch, ensuring that it is against `dmz` and NOT `develop` (Say it with me folks: branch off develop, merge into dmz). Get an admin for the repository (@wheelerlaw) to sign off on your changes and merge the PR into `dmz`. 

Wait a few minutes and your changes will show up on the site. You might need to clear your browser cache. 
