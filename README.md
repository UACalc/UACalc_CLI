This is the main Git repository for UACalc_CLI, which provides a command line interface to the [Universal Algebra Calculator](http://uacalc.org).


Introduction
============
Jython is an implementation of (the scripting language) Python in Java. It has the advantage (for us) that it can read Java libraries the the uacalc.jar library.  Therefore, the Jython interpreter can be used as a command line interface (CLI) to the UACalc.  

(The functional programming language Scala provides an alternative CLI to the UACalc, as described [here](http://universalalgebra.wordpress.com/documentation/scala/scala-repl-with-uacalc-objects/).)


Installation
============
There are three ways to install and configure the command line version of the UACalc.  They should all leave you with the following directories:

    UACalc_CLI/Algebras
    UACalc_CLI/Examples
    UACalc_CLI/CLI

including a script `UACalc_CLI/CLI/uacalc` which starts the Jython interpreter
with UACalc dependencies preconfigured. If you try any of the methods described
below and you have problems, please
[report the issue](https://github.com/UACalc/UACalc_CLI/issues). 

Method 1: simple tar file download
----------------------------------
Assuming you already have Java installed, or you want to install it yourself, this 
method may work for you and is probably the simplest.

1.  Download the file

        http://uacalc.org/Jython/UACalc_CLI.tar

2.  Extract this tar archive with a command like the following:

        tar xvf UACalc_CLI.tar

    **Note:** If you already have a `UACalc_CLI` directory, you can prevent tar from
    overwriting files that are newer than those in the archive with the
    `--keep-newer-files` option, as follows:

        tar --keep-newer-files xvf UACalc_CLI.tar

    Consider also the -w option.

To start using UACalc at the command line, see section
[Starting the UACalc CLI](#starting-the-uacalc-cli) below.


Method 2: automatic setup script for Ubuntu
-------------------------------------------
The setup.sh script in this repository will automatically set up everything on
Ubuntu Linux. If you are not using Ubuntu, you can read the comments in the
setup.sh file, and do the analogous steps for your platform.  (We are in the
process of generalizing the setup.sh script so that it works on other operating
systems.) 

Issue the following commands in a terminal window (at the shell prompt):

    wget https://raw.githubusercontent.com/UACalc/UACalc_CLI/master/setup.sh
    chmod a+x setup.sh
    ./setup.sh

To start using UACalc at the command line, see section
[Starting the UACalc CLI](#starting-the-uacalc-cli) below.

Method 3: clone this git repository
-----------------------------------
If you have git installed, you can clone this repository with, e.g., 

        cd ~/git
        git clone https://github.com/UACalc/UACalc_CLI.git

This will give you everything you need to start using UACalc at the command
line, as explained in the next section.

(For UACalc team members, the notes below describe how to clone in such a way
that GitHub won't ask for login credentials everytime you push changes to the
repository.)


Starting the UACalc CLI
=======================
**IMPORTANT** After using one of the methods described above for obtaining the
software, you must open the file called `UACalc_CLI/CLI/uacalc.py` in an editor
and change the value of the variable `UACALC_CLI_ROOT` to the fully qualified
name of your UACalc_CLI directory; that is, set `UACALC_CLI_ROOT` equal to the
directory that contains the Algebras, Examples, and CLI subdirectories.

Start the Jython interpreter by running the script `uacalc`.  For example, from
within the UACalc_CLI/CLI directory, you could enter `./uacalc` on the command
line of a terminal window. 

You may wish to add the UACalc_CLI/CLI directory to your search $PATH,
so that in the future you can simply type `uacalc` on the command line.

Constructing an Algebra
=======================
Python code demonstrating the construction of a (universal) algebra is 
in the file `UACalc_CLI/Examples/AlgebraConstructionExample.py`.

If you have Jython installed separately, you can run the commands in a .py file
by entering, for example,

    jython AlgebraConstructionExample.py 

in a terminal window.  This will create two algebra files in the Algebras
directory (which can be loaded into UACalc).  If you don't have Jython installed
separately, you can run the file with 

    java -jar UACalc_CLI/CLI/Jars/jython.jar -i UACalc_CLI/Examples/AlgebraConstructionExample.py


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

        [ralph@mahiloa:~/git/UACalc_CLI/CLI]$ uacalc
        
        Starting Jython with UACalc dependencies.  Please be patient...

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Welcome to the command line version of UACalc!
            to exit type quit()
            (more help coming)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        >>> f3 = AlgebraIO.readAlgebraFile("/home/ralph/git/UACalc_CLI/Algebras/f3.ua")
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


Additional information
======================
+ [uacalc.org](http://uacalc.org) (the official UACalc website)
+ [universalalgebra.org](http://universalalgebra.wordpress.com/documentation/uacalc/)  
+ [williamdemeo.github.io/uacalc](http://williamdemeo.github.io/uacalc/)


--------------------------------------

Notes/reminders for administrators
----------------------------------
To create a new tar file from the git repository, use the following commands:

    cd ~/git    # assuming repository is in ~/git/UACalc_CLI
    tar --exclude=.git --exclude=setup.sh --exclude=*~ -cvf UACalc_CLI.tar UACalc_CLI

This excludes the git repository and the setup.sh file from the resulting UACalc_CLI.tar file.
We might also consider the -u (update) option to only append files that are newer than 
those already in the archive.

If you have a GitHub account and have setup ssh-keys, you might prefer to clone
the repository with the following command instead of the http version mentioned above.

    git clone git@github.com:UACalc/UACalc_CLI.git

That way GitHub won't ask for your credentials everytime you want to push
something to the repo.  Alternatively, if you have already used the http method
of cloning the repo, you can switch to ssh using the following command:

    git remote set-url origin git@github.com:UACalc/UACalc_CLI.git

See also: [GitHub doc on switching remote url](https://help.github.com/articles/changing-a-remote-s-url/#switching-remote-urls-from-https-to-ssh)

------------------------

At some point in October 2014 this whole repository was inadvertantly overwritten with the uacalcsrc source code tree, so the following commands were issued to take us back to the previous state of the repository (from March 2014):

1. Reset the index to the desired tree

        git reset 56e05fced

2. Move the branch pointer back to the previous HEAD

        git reset --soft HEAD@{1}

        git commit -m "Revert to 56e05fced"

3. Update working copy to reflect the new commit

        git reset --hard

4. clean up any untracked files that lingered about.

        git clean -f -d 

see: http://stackoverflow.com/questions/1895059/revert-to-a-commit-by-a-sha-hash-in-git

(This could have been done with one simple command like `git reset --hard 6fad311`, but the foregoing is clearer.)



