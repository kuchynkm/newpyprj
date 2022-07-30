# NewPyPrj: automation of python project setup with pyenv + poetry + git

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
I recommend to clone the script, edit the default values as needed, make it executable and add it to your `$PATH`.
This way, you will be able to run it from anywhere with `./newpyprj.sh`. At least that's the way I use it :)