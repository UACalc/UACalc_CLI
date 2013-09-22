#!/bin/bash
# Simple setup.sh for configuring Jython for use with UACalc
# William DeMeo <williamdemeo@gmail.com>

set -e

echo
echo 'This script will install the software and configuration files'
echo 'necessary to use the command line version of UACalc.'
echo
echo 'Here is a summary of what this script does:'
echo
echo '    1.  Setup UACalc home directory.'
echo "    2.  Install Git and clone the UACalc GitHub repository into ~/git/UACalc."
echo "    3.  Setup Java (openjdk-7-jdk), unless a suitable JRE is already present."
echo "    4.  Create symbolic link to uacalc command at ~/bin/uacalc."
echo
read -p 'Abort this setup script? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    echo
    echo 'Setup aborted.'
    echo
    exit 1
fi

# PATH Definitions.  If the script doesn't seem to be working, check these first.
uacalc_path=$HOME'/UACalc'
uacalc_algebras_path=$uacalc_path'/Algebras'
uacalc_examples_path=$uacalc_path'/Examples'
uacalc_cli_path=$uacalc_path'/UACalc_CLI'
git_path=$HOME'/git'
uacalc_git_path=$git_path'/UACalc'
uacalc_git_algebras_path=$uacalc_git_path'/Algebras'
uacalc_git_examples_path=$uacalc_git_path'/Examples'
uacalc_git_cli_path=$uacalc_git_path'/UACalc_CLI'

echo
echo
echo "Step 1.  Setting up UACalc home directory."
echo

cd $HOME
#
# If ~/UACalc doesn't already exist, create it.
#
mkdir -p $uacalc_path



echo 
echo "Step 2.  Installing Git and cloning UACalc GitHub repository."
echo
sudo apt-get update
sudo apt-get install -y git-core

#
# If the directory ~/git/UACalc exists, pull the latest version.
#
if [ -d $uacalc_git_path/ ]; then
    echo '         Updating '$uacalc_git_path' to the latest version.'
    cd $uacalc_git_path
    #git remote add origin git@github.com:UACalc/UACalc.git
    git pull
else
    # Otherwise, change into $HOME/git and clone the git repo.
    cd $git_path
    git clone https://github.com/UACalc/UACalc.git
fi

# 
# UACalc.git repo comes with a uacalc.jar file.
# Let's make sure it's the newest one available:
echo
echo "         Checking for newer uacalc.jar..."
echo
cd $uacalc_cli_path'/Jars'
wget -N http://uacalc.org/uacalc.jar
cd $uacalc_path

# from repository version: ~/git/UACalc/Algebras 
# to local version: ~/UACalc/Algebras directory.
# If they already exist, rename with ~ extension.
echo
echo "         Copying .ua algebra files"
echo
echo "            FROM  "$uacalc_git_algebras_path
echo
echo "            TO    "$uacalc_algebras_path
echo 
echo "         Any pre-existing .ua files will be renamed with .ua~ extension."
echo
mkdir -p $uacalc_algebras_path
cp -b $uacalc_git_algebras_path/*.ua $uacalc_algebras_path/

echo
echo "         Copying examples"
echo
echo "            FROM  "$uacalc_git_examples_path
echo
echo "            TO    "$uacalc_examples_path
echo 
echo "         Any pre-existing files will be renamed with ~ extension."
echo
mkdir -p $uacalc_examples_path
cp -b $uacalc_git_examples_path/* $uacalc_examples_path/

# Use rsync with -aiu options to copy UACalc_CLI directory so local files
# overwritten if and only if they are older than the repository version.
rsync -aiu $uacalc_git_cli_path/ $uacalc_cli_path/

echo
echo "Step 3.  Setting up Java."
echo
if type -p java; then
    echo '         Found Java executable in PATH.'
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo '         Found Java executable in JAVA_HOME.'
    _java="$JAVA_HOME/bin/java"
else
    echo
    read -p '         No Java found. Install it? [Y/n]' -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	sudo apt-get install openjdk-7-jdk
    else
	echo 
	echo '         Aborting setup.'
	echo
	exit 1
    fi
fi

#
# Check Java version is recent enough.
#
if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.5" ]]; then
        echo '         java version is more than 1.5... ok'
    else         
        read -p '         java version is less than 1.5... install new version? [Y/n]' -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    sudo apt-get install openjdk-7-jdk
	else
	    echo '         '
	    echo '         Aborting setup. (You need a recent version of Java to use Jython.)'
	    echo 
	    exit 1
	fi
    fi
fi

echo
echo "Step 4.  Create symbolic link to uacalc command."
echo
if [ ! -d $HOME/bin/ ]; then
    mkdir -v $HOME/bin
fi
uacalc_name='uacalc'
uacalc_link=$HOME'/bin/'$uacalc_name
uacalc_fqname=$uacalc_cli_path'/'$uacalc_name
echo '         Adding a link to startup script at '$uacalc_link
if [ -h "$uacalc_link" ]; then
    echo ""
    echo "         "$uacalc_link" already exists."
    read -p '         Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mv $uacalc_link $uacalc_link'_'$(date +'%Y%m%d:%H:%m')
	ln -s $uacalc_fqname $uacalc_link
    else
	echo 
	echo "         Okay, then typing "$uacalc_name" might not work, but you can always try"
	echo "              "$uacalc_fqname
	echo
    fi
else
	ln -s $uacalc_fqname $uacalc_link
fi
echo
echo
echo 'FINISHED UACalc_CLI Setup!'
echo
echo '   To run the command line version of UACalc'
echo '   (i.e. the Jython interpreter with UACalc dependencies)'
echo '   enter'
echo
echo '       ~/bin/'$uacalc_name
echo
echo '   If you get an error, try the fully qualified name of the startup script:'
echo 
echo '       '$uacalc_fqname
echo
echo '   Look at the file AlgebraConstructionExample.py for some examples'
echo '   of Jython/UACalc code you can enter at the Jython >>> prompt.'
echo
