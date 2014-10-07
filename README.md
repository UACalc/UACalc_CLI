<<<<<<< HEAD
The main Universal Algebra Calculator website is http://uacalc.org

This git repository was initially created by importing Ralph Freese's uacalcsrc cvs repository from sourceforge using the following command:

    git cvsimport -C ~/git/uacalc -r cvs -k -v -d :pserver:anonymous@uacalc.cvs.sourceforge.net:/cvsroot/uacalc uacalcsrc

(But first git-cvsimport had to be installed with `sudo apt-get install git-cvsimport`)

I will attempt to keep this git repo reasonably up-to-date with the Sourceforge cvs repository by periodically running the command above and then doing `git push origin master`.

(But hopefully Ralph will eventually switch to git. :)
=======
This is the main Git repository for UACalc.  If you don't use Git, you might prefer [this page](http://uacalc.github.io/UACalc/).


Introduction
============
Jython is an implementation of (the scripting language) Python in Java. It has the advantage (for us) that it can read Java libraries the the uacalc.jar library.  Therefore, the Jython interpreter can be used as a command line interface (CLI) to the UACalc.  

(The functional programming language Scala provides an alternative CLI to the UACalc, as described [here](http://universalalgebra.wordpress.com/documentation/scala/scala-repl-with-uacalc-objects/).)

For more information, please visit [universalalgebra.org](http://universalalgebra.wordpress.com/documentation/uacalc/).

Installation
============
There are three ways to install and configure the command line version of the UACalc.  They should all leave you with the following directories:

    ~/UACalc/Algebras
    ~/UACalc/Examples
    ~/UACalc/UACalc_CLI

including a script ~/UACalc/UACalc_CLI/uacalc which starts the Jython interpreter with UACalc dependencies preconfigured.
If you try any of the methods described below and you have problems, please [report the issue](https://github.com/UACalc/UACalc/issues).

Method 1: simple tar file download
----------------------------------
Assuming you already have Java installed, or you want to install it yourself, this 
method may work for you and is probably the simplest.

1.  Download the UACalc.tar file from: http://uacalc.org/Jython/UACalc.tar
    and put it in your home directory.
2.  Extract this tar archive into your home directory with a command like the following:

        tar xvf UACalc.tar

    Or, if you already have a ~/UACalc directory, you can prevent tar from overwriting
    files that are newer than those in the archive with (consider also the -w option):

        tar --keep-newer-files xvf UACalc.tar

Method 2: automatic setup script for Ubuntu
-------------------------------------------
The setup.sh script in this repository will automatically set up everything on Ubuntu Linux.  
If you are not using Ubuntu, you can read the comments in the setup.sh file, and do the analogous 
steps for your platform.  (We are in the process of generalizing the setup.sh script so that it 
works on other flavors of Linux, and eventually on Macs too.)

Issue the following commands in a terminal window (at the shell prompt):

1.  wget https://raw.github.com/UACalc/UACalc/master/setup.sh

2.  chmod a+x setup.sh

3.  ./setup.sh

Method 3: clone this git repository
-----------------------------------
If you have git installed, you can clone this repository, and then copy what you need from 
it into your ~/UACalc directory.

1.  Change to the directory where you want to keep the repository; e.g.,

        cd ~/git

2.  Clone the repository:

        git clone git@github.com:UACalc/UACalc.git

3.  Copy what you need into the right places; e.g., some subset of the following commands,
    (depending on what you may already have, or what you'd like to update):

        mkdir -p ~/UACalc
        mkdir -p ~/UACalc/Algebras
        mkdir -p ~/UACalc/Examples
        cp -b ~/git/UACalc/Algebras/*.ua ~/UACalc/Algebras/
        cp -b ~/git/UACalc/Examples/*.py ~/UACalc/Examples/
        rsync -aiu ~/git/UACalc/UACalc_CLI/ ~/UACalc/UACalc_CLI/


Executing scripts
=================
Start the Jython interpreter by entering the following at the command line:

    ~/UACalc/UACalc_CLI/uacalc

You may wish to put a link to this command in your ~/bin directory as follows:

    ln -s ~/UACalc/UACalc_CLI/uacalc ~/bin/uacalc

The file ~/UACalc/UACalc_CLI/uacalc.py has definitions used in an interactive session, and the uacalc command invoked above is just shorthand for the following: 

    java -jar ~/UACalc/UACalc_CLI/Jars/jython.jar -i ~/UACalc/UACalc/UACalc_CLI/uacalc.py

Look at the file ~/UACalc/Examples/AlgebraConstructionExample.py.  This is an example script showing how to use python to construct an algebra.  If you have Jython installed separately, you can run the commands in this file by typing  

    jython AlgebraConstructionExample.py 

in a terminal window.  This will create two algebra files in the Algebras directory (which can be loaded into UACalc).  If you don't have Jython installed separately, you can run the file with

    java -jar ~/UACalc/UACalc_CLI/Jars/jython.jar -i ~/UACalc/UACalc/Examples/AlgebraConstructionExample.py


An interactive session
======================
You can call some hidden methods: for example, if you go to the javadoc link, click on CongruenceLattice on the left, you will find a method 

    commutator(BinaryRelation S, BinaryRelation T). 

(There are also methods for the weak and strong rectangularity commutators, as well as centrality methods.)

The sample interactive session below does the following:

1.  Read in the algebra f3 (the reduct of the three element field to multiplication).

2.  Check its cardinality.

3.  Define theta to be the nontrivial congruence and define one to be the top.

4.  Check the commutator [theta,one] = zero but [one,theta] = theta.

5.  Quit.

        [ralph@mahiloa:~/UACalc/UACalc_CLI]$ uacalc
        
        Starting Jython with UACalc dependencies.  Please be patient...

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Welcome to the command line version of UACalc!
            to exit type quit()
            (more help coming)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        >>> f3 = AlgebraIO.readAlgebraFile("/home/ralph/UACalc/Algebras/f3.ua")
        >>> f3.cardinality()
        3
        >>> conlat = f3.con().getUniverseList()
        >>> conlat
        [|0|1|2|, |0|1,2|, |0,1,2|]
        >>> theta = conlat[1]
        >>> theta
        |0|1,2|
        >>> one = conlat[2]
        >>> one
        |0,1,2|
        >>> f3.con().commutator(theta,one)
        |0|1|2|
        >>> f3.con().commutator(one,theta)
        |0|1,2|
        >>> quit()


Notes/reminders for the administrators
--------------------------------------
To create a new tar file from the git repository, use the following commands:

    cd ~/git    # assuming repository is in ~/git/UACalc
    tar --exclude=.git --exclude=setup.sh --exclude=*~ -cvf UACalc.tar UACalc

This excludes the git repository and the setup.sh file from the resulting UACalc.tar file.
We might also consider the -u (update) option to only append files that are newer than 
those already in the archive.



>>>>>>> 6fad31160076595cf8b2c5ba2f5ed96f4d1fbfa0

