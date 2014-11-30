UACalc_CLI
==========

This is the main Git repository for UACalc_CLI, which provides a command line
interface to the [Universal Algebra Calculator](http://uacalc.org).
You are now reading the contents of the README.md file, which explains how to
set up the command line interface to the universal Algebra Calculator, and then
gives a few examples demonstrating how to import and use UACalc classes on the
command line. 


Introduction and Motivation
---------------------------
This section briefly describes some background and motivation for this GitHub repository.
If you already know what the UACalc is and why you would want to use it from the
command line, you can skip to the next section on [Installation](#installation)
of the UACalc command line interface (CLI).

The Universal Algebra Calculator ([UACalc](http://uacalc.org))
is powerful software for studying and experimenting
with general (universal) algebras. It is written entirely in Java and it has a
very nice, user friendly graphical user interface (gui). The UACalc lacks a
command line interface (cli), and for some tasks we might prefer a cli over a
gui. 

A common scenario is the following: we wish to construct a large collection of
algebras and, iterating over this collection, use some functionality provided by
UACalc to search for a counterexample to some conjecture. One solution would be
to write a Java program to do this, since we can access the opensource Java
classes and methods provided by UACalc.  Although Java is a nice language that
makes programming relatively painless, it is still time consuming to write a
decent, correct Java program.  For fast prototyping and experimentation, it
would be nice to have a scripting language interface to UACalc. Jython provides
this. 

Jython is an implementation of (the scripting language) Python in Java. It has
the advantage (for us) that it can read Java libraries the the uacalc.jar
library.  Therefore, the Jython interpreter can be used as a command line
interface (CLI) to the UACalc.

The [Scala programming language](http://www.scala-lang.org/) provides an
alternative CLI to the UACalc, as briefly described
[here](http://universalalgebra.wordpress.com/documentation/scala/scala-repl-with-uacalc-objects/).
More support for Scala programming with UACalc packages is currently under
development. (For more info, [contact williamdemeo](mailto:williamdemeo@gmail.com).)

The next section describes a few ways to install and configure a command line
version of UACalc.  Later sections show how to import UACalc classes from the Jython
command line interpreter, and then use simple Python syntax to work with the
resulting UACalc objects. 


Installation
------------
There are three ways to install and configure the command line version of the UACalc.  They should all leave you with the following directories:

    UACalc_CLI/Algebras
    UACalc_CLI/Examples
    UACalc_CLI/CLI

including a script `UACalc_CLI/CLI/uacalc` which starts the Jython interpreter
with UACalc dependencies preconfigured. If you try any of the methods described
below and you have problems, please
[report the issue](https://github.com/UACalc/UACalc_CLI/issues). 

**NOTE:** If you are already familiar with Jython, it's not absolutely necessary
  to follow the full setup procedure described below. All you really need is the
  [uacalc.jar](http://uacalc.org/uacalc.jar) file.  See the section below
  [For Experienced Jython Users](#for-experienced-jython-users).
  With that, you could start Jython and then do at least the following before
  trying some of the examples in the
[UACalc_CLI/Examples](https://github.com/UACalc/UACalc_CLI/tree/master/Examples) directory.

        >>> import sys
        >>> sys.path.append("/home/username/uacalc.jar")

  (See the file
  [UACalc_CLI/CLI/uacalc.py](https://raw.githubusercontent.com/UACalc/UACalc_CLI/master/CLI/uacalc.py) for other configuration options.)


Method 1: simple tar file download
----------------------------------
Assuming you already have Java installed, or you want to install it yourself, this 
method may work for you and is probably the simplest.

1.  Download the file [http://uacalc.org/Jython/UACalc_CLI.tar](http://uacalc.org/Jython/UACalc_CLI.tar)

2.  Extract this tar archive with a command like the following:

        tar xvf UACalc_CLI.tar

    **Note:** If you already have a `UACalc_CLI` directory, you can prevent tar from
    overwriting files that are newer than those in the archive by using the
    `--keep-newer-files` option.  That is, instead of the tar
    command above, you could invoke the following:

        tar --keep-newer-files xvf UACalc_CLI.tar

    (Alternatively, consider tar's -w option.)

To start using UACalc at the command line, see section
[Starting the UACalc CLI](#starting-the-uacalc-cli) below.


### Method 2: automatic setup script for Ubuntu
The [setup.sh](https://raw.githubusercontent.com/UACalc/UACalc_CLI/master/setup.sh)
script in this repository will automatically set up everything on a
Ubuntu Linux system. If you are not using Ubuntu, you can read the comments in the
setup.sh file, and follow the analogous steps for your platform.
(Work on generalizing the setup.sh script so that it runs on other operating
systems is in progress.) 

The setup.sh script can be run on a Ubuntu Linux system by issuing the following
commands in a terminal window (at the shell prompt): 

    wget https://raw.githubusercontent.com/UACalc/UACalc_CLI/master/setup.sh
    chmod a+x setup.sh
    ./setup.sh

To start using UACalc at the command line, see section
[Starting the UACalc CLI](#starting-the-uacalc-cli) below.

### Method 3: clone this git repository
If you have git installed, you can clone this repository with the command

    git clone https://github.com/UACalc/UACalc_CLI.git

This will give you everything you need to start using UACalc at the command
line, as explained in [the next section](#starting-the-uacalc-cli).

(For UACalc team members, the notes below describe how to clone in such a way
that GitHub won't ask for login credentials every time you push changes to the
repository.)


Starting the UACalc CLI
-----------------------
**IMPORTANT** After using one of the methods described above for obtaining the
software, you must open the file called `UACalc_CLI/CLI/uacalc.py` in an editor
and change the line

    UACALC_CLI_ROOT = expanduser("~/git/UACalc_CLI")

so that the string "~/git/UACalc\_CLI" is the fully qualified
name of your UACalc_CLI directory.

That is, `UACALC_CLI_ROOT` must be equal to the directory on your system that
contains the Algebras, Examples, and CLI subdirectories.

Start the Jython interpreter by running the script `uacalc`.  For example, from
within the UACalc_CLI/CLI directory, you could enter `./uacalc` on the command
line of a terminal window. 

You may wish to add the UACalc_CLI/CLI directory to your search $PATH,
so that in the future you can simply type `uacalc` on the command line.


An interactive session
----------------------
Here we describe a brief interactive Jython session that makes use of some
UACalc methods.  For more examples, visit the 
[UACalc_CLI/Examples](https://github.com/UACalc/UACalc_CLI/tree/master/Examples) directory.

You can call some "hidden" UACalc methods (that don't yet appear in the gui
menu). For example, if you go to the javadoc link, click on CongruenceLattice on
the left, you will find a method

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


------------------------------------------

User feedback and contributions
-------------------------------
We depend on feedback from the user community.  If you find any that doesn't
work, please open a new issue.

On the other hand, if you have found the command line interface to UACalc useful
in your work, please consider sharing some example code with the community.  You
can email [Ralph Freese](mailto:ralph@math.hawaii.edu) or
[William DeMeo](mailto:williamdemeo@gmail.com), or post to the
[UACalc_CLI Wiki](https://github.com/UACalc/UACalc_CLI/wiki) (requires GitHub login). 

----------------------------------------------

Additional information
----------------------
+ More examples are described in the [UACalc_CLI/Examples](https://github.com/UACalc/UACalc_CLI/tree/master/Examples) directory.
+ To see what UACalc packages you can import on the Jython command line,
and to learn about their methods, consult the [UACalc javadocs](http://uacalc.org/doc/).
+ The official UACalc website is [uacalc.org](http://uacalc.org).

--------------------------------

For Experienced Jython Users
----------------------------
If you are already familiar with Jython, it's not absolutely necessary
to follow the setup procedure described above. All you really need is the
[uacalc.jar](http://uacalc.org/uacalc.jar) file. With that file, you could start
Jython and then invoke the following two commands:

        >>> import sys
        >>> sys.path.append("/home/username/uacalc.jar")

Then you should already be able to try some of the examples described in the
[UACalc_CLI/Examples](https://github.com/UACalc/UACalc_CLI/tree/master/Examples) directory.

See the file [UACalc_CLI/CLI/uacalc.py](https://raw.githubusercontent.com/UACalc/UACalc_CLI/master/CLI/uacalc.py) for other configuration options.

-----------------------------------------------------

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

That way GitHub won't ask for your credentials every time you want to push
something to the repo.  Alternatively, if you have already used the http method
of cloning the repo, you can switch to ssh using the following command:

    git remote set-url origin git@github.com:UACalc/UACalc_CLI.git

See also: [GitHub doc on switching remote url](https://help.github.com/articles/changing-a-remote-s-url/#switching-remote-urls-from-https-to-ssh)

------------------------

At some point in October 2014 this whole repository was inadvertently overwritten with the uacalcsrc source code tree, so the following commands were issued to take us back to the previous state of the repository (from March 2014):

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



