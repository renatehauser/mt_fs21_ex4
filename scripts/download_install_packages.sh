#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

tools=$base/tools
mkdir -p $tools

echo "Make sure this script is executed AFTER you have activated a virtualenv"

# install joeynmt
# pip install -e sets the installation to "editable" mode and allows us to edit the code without having to reinstall it

git clone https://github.com/joeynmt/joeynmt $tools/joeynmt

(cd $tools/joeynmt && pip install -e .)

# install Moses scripts for preprocessing

git clone https://github.com/bricksdont/moses-scripts $tools/moses-scripts
