# NewPyPrj: automation of python project setup with pyenv + poetry + git

It takes several steps to properly setup a python project according to the latest best practices. 

Typically, these involve creating a folder structure for the project, setting up python with a fresh virtual environment, git repository initialization, configuration of pre-commit hooks and more.  

I compiled all the repetitive steps I do everytime I create a new python project into a single bash script and made it available here.

Feel free to adjust it to your needs. Edit the script's default values or add & remove steps to your liking.


## Prerequestities

You need to have the following tools installed already:
* pyenv
* poetry
* git 


## Description

### You will:
* choose python version for the project
* set the project name

### The script will:
* install the chosen python version with pyenv
* create a directory with a new poetry project 
* set the installed python version as local for that directory
* configure virtualenvs.in-project (true/false)
* initialize git repo and create a base .gitignore file
* add pre-commit to dev dependencies
* fetch a pre-commit config with a few useful hooks (black + isort + flake8 + pylint + mypy) from [here](https://github.com/kuchynkm/pre-commit-hooks-template.git)
* setup pre-commit hooks (install and autoupdate)
* run the hooks and create initial commit
* show the resulting project structure and point you to next steps


## Usage
I recommend to clone the script, edit it as needed and make it executable.

For future convenience, append it to `$PATH` via your `~/.bashrc`, `~/.zshrc` or 
whatever alternative your shell is using.

This way, you will be able to run it from anywhere, anytime. At least that's the way I use it :)
