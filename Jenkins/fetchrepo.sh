#!/bin/bash -l

clear

# Constants
c_branch=${1}

# GIT
if [[ -d kapida-ios ]]; then
echo 🚀🚀🚀🚀🚀 REPOSITORY EXIST 🚀🚀🚀🚀🚀
else
echo 🚀🚀🚀🚀🚀 CLONE REPOSITORY 🚀🚀🚀🚀🚀
    git clone -b $c_branch git@github.com-a101kapida-ios:loodos/a101-kapida-ios.git kapida-ios
fi


# Branch
echo 🚀🚀🚀🚀🚀 CHECKOUT BRANCH 🚀🚀🚀🚀🚀
cd kapida-ios
git fetch
git checkout $c_branch
git pull origin $c_branch
cd ..
