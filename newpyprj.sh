#!/bin/bash
# Shell script for automatic python project setup with pyenv, poetry and pre-commit hooks
# Source: https://github.com/kuchynkm/newpyprj.git

# DEFAULT values (customize as needed)
PYTHON_VERSION="3.10.5"
PROJECT_NAME="new_project"
INPROJECT_VENV=true
PRECOMMIT_INSTALL=true
PRECOMMIT_AUTOUPDATE=true
MAIN_BRANCH="master"
INIT_COMMIT_MSG="initial commit"
GITIGNORE=".idea
.vscode
__pycache__
.python-version"


# setup python version
printf "Python version (default $(echo "$PYTHON_VERSION")): "
read -r pyversion
if [[ -z $pyversion ]] ; then
    pyversion=$PYTHON_VERSION
fi
pyenv install $pyversion


# create a new poetry project
printf "Project name (default $(echo $PROJECT_NAME)): "
read -r project_name
if [[ -z $project_name ]] ; then
    project_name=$PROJECT_NAME
fi


# create a project directory and set $pyversion as local
mkdir $project_name
cd $project_name
pyenv local $pyversion


# to avoid unnecessary nested directories, create poetry project 
# in $project_name/tmp and move its content one level up
poetry new tmp --name $project_name
cp -a tmp/. .
rm -rf tmp


# in-project .venv creation 
poetry config --local virtualenvs.in-project $INPROJECT_VENV


# initialize git repo
git init --quiet


# make .gitignore
echo "$GITIGNORE" > .gitignore


# add pre-commit hooks
poetry add pylint pre-commit --dev


# fetch yaml template from my pre-commit config repo
echo $'\nGetting pre-commit config template from https://github.com/kuchynkm/pre-commit-hooks-template.git ...'
curl --silent --show-error https://raw.githubusercontent.com/kuchynkm/pre-commit-hooks-template/master/.pre-commit-config.yaml  -O

# fetch .flake8 and mypy.ini from my linter config repo
echo $'Getting pre-commit config template from https://github.com/kuchynkm/linter-configs.git ...'
curl --silent --show-error https://raw.githubusercontent.com/kuchynkm/linter-configs/master/.flake8  -O
curl --silent --show-error https://raw.githubusercontent.com/kuchynkm/linter-configs/master/mypy.ini  -O


# setup pre-commit hooks
if [ "$PRECOMMIT_INSTALL" = true ] ; then
    poetry run pre-commit install
fi
if [ "$PRECOMMIT_AUTOUPDATE" = true ] ; then
    poetry run pre-commit autoupdate
fi


# run pre-commit hooks
echo $'\nRunning pre-commit hooks ...'
git add .
poetry run pre-commit run --all-files


# make initial commit
echo $'\nMaking initial commit ...'
git add .
git commit -m "'${INIT_COMMIT_MSG}'"
git branch -M $MAIN_BRANCH


# show project structure
echo $'\nCurrent project structure:'
ls -al


# show next steps
cat << EndOfMessage

Next steps:
    * cd $project_name
    * git remote add origin <remote origin>
    * git push -u origin $MAIN_BRANCH

EndOfMessage
