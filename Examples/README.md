Examples
========
To get some idea of some of the basic things that are possible, look at the file
AlgebraConstructionExample.py. This is an example script
showing how to use Python to construct an algebra. Below are some other
examples (with more to follow).

---------------------------------------------

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

  - [First Steps: composing partitions](#first-steps-composing-partitions)
  - [Constructing algebras](#constructing-algebras)
  - [The commutator](#the-commutator)
  - [Batch testing](#batch-testing)
  - [More information](#more-information)
  - [User feedback and contributions](#user-feedback-and-contributions)
  - [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

----------------------------------------

## First Steps: composing partitions
1. Once you have configured Jython and started the interpreter as described
[here](https://github.com/UACalc/UACalc_CLI), you can **import some UACalc
packages**, for example,

        >>> from org.uacalc import alg

2. **Instantiating classes** is much simpler in Python than in Java.
   For example, to define a BasicPartition object, like `|0,1|2,3|`, simply do

        >>> a = alg.conlat.BasicPartition("|0,1|2,3|")

   It's even easier if we import the BasicPartition class first:

        >>> from org.uacalc.alg.conlat import BasicPartition
        >>> a = BasicPartition("|0,1|2,3|")

   You can do catch-all imports with the * wildcard. For instance,

        >>> from org.uacalc.alg import *
        >>> a = conlat.BasicPartition("|0,1|2,3|")

   but you should use such import statements sparingly because they cause Jython to
   put wrappers around every class and method in the named package.

3. Once you have instantiated an object, you can invoke its `toString()` method
   by simply entering its name at the prompt: 

        >>> a
        |0,1|2,3|

   Alternatively, you can `print` it:

        >>> print a
        |0,1|2,3|


   To summarize, let's go though a simple example from the beginning.

        >>> from org.uacalc.alg import *
        >>> a = conlat.BasicPartition("|0,1|2,3|")
        >>> b = conlat.BasicPartition("|0|1,2|3|")
        >>> a, b
        (|0,1|2,3|, |0|1,2|3|)
    
        >>> print a, b
        |0,1|2,3| |0|1,2|3|
        >>> c, d = a, b
        >>> c, d
        (|0,1|2,3|, |0|1,2|3|)
        >>> compab = a.compose(b)
        >>> compab
        [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]]
        >>> parts = a, b, c, d
        >>> parts
        (|0,1|2,3|, |0|1,2|3|, |0,1|2,3|, |0|1,2|3|)
        >>> for p in parts:
        ...     p.rank()
        ... 
        2
        1
        2
        1

## Constructing algebras
Python code demonstrating the construction of a (universal) algebra is 
in the file `UACalc_CLI/Examples/AlgebraConstructionExample.py`.

If you have Jython installed separately, you can run the commands in a .py file
by entering, for example,

    jython AlgebraConstructionExample.py 

in a terminal window.  This will create two algebra files in the Algebras
directory (which can be loaded into UACalc).  If you don't have Jython installed
separately, you can run the file with 

    java -jar UACalc_CLI/CLI/Jars/jython.jar -i UACalc_CLI/Examples/AlgebraConstructionExample.py



## The commutator
You can call some of the UACalc's "hidden methods" (that don't appear in the gui
menu). For example, if you go visit the
[UACalc javadocs](http://uacalc.org/doc/) and click on [CongruenceLattice](http://uacalc.org/doc/org/uacalc/alg/conlat/CongruenceLattice.html) in
the lower left pane, you will find the method

    commutator(BinaryRelation S, BinaryRelation T)

(There are also methods for the weak and strong rectangularity commutators, as well as centrality methods.)

The sample interactive session below does the following:

1. Read in the algebra f3 (the reduct of the three element field to multiplication).
2. Check its cardinality.
3. Define theta to be the nontrivial congruence and define one to be the top.
4. Check the commutator [theta,one] = zero but [one,theta] = theta.
5. Quit

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
		
## Batch testing
Suppose we have a bunch of .ua algebra files in our UACalc_CLI/Algebras
directory, say, Alg1.ua, Alg2.ua,..., Alg9.ua, each one containing a finite
idempotent algebra. We want to check whether the varieties generated by these 
algebras are congruence distributive or congruence permutable.

[Freese and Valeriote](http://www.math.hawaii.edu/~ralph/Preprints/IJAC_1901_P41.pdf)
[1] discovered polynomial time algorithms to test for these properties.

Here's how one could use Jython to call the UACalc methods that perform these
tests:

    from org.uacalc.alg.Malcev import isCongruenceDistIdempotent
    from org.uacalc.alg.Malcev import cpIdempotent
    from org.uacalc.io import AlgebraIO

    homedir = "/home/williamdemeo/git/UACalc_CLI/"

    outfile1 = open(homedir+"isCD.txt", 'w')
    outfile2 = open(homedir+"isCP.txt", 'w')

    for k in range(1,10):
        algname = "Alg"+str(k)
        algfile = homedir+"Algebras/"+algname+".ua"
        A = AlgebraIO.readAlgebraFile(algfile)
        outfile1.write(algname+"   "+str(isCongruenceDistIdempotent(A, None))+"\n")
        outfile2.write(algname+"   "+str((cpIdempotent(A, None)==None))+"\n")
        
    outfile1.close()
    outfile2.close()

The output will be stored in the isCD.txt and isCP.txt files, and will 
look something like this:

    Alg1    True
	Alg2    True
	Alg3    False
	Alg4    True...

with True in the isCD.txt (resp, isCP.txt) file meaning the algebra generates a
variety that is congruence distributive (resp, permutable).

------------------------------------------------

## More information
The above presents some simple examples using only a few UACalc packages.
To see what other UACalc packages you can import, and to learn about
their methods, consult the [UACalc javadocs](http://uacalc.org/doc/).

---------------------------------------------------------------

## User feedback and contributions
We depend on feedback from the user community.  If you find any that doesn't
work, please open a new issue.

On the other hand, if you have found the command line interface to UACalc useful
in your work, please consider sharing some example code with the community.  You
can email [Ralph Freese](mailto:ralph@math.hawaii.edu) or
[William DeMeo](mailto:williamdemeo@gmail.com), or post to the
[UACalc_CLI Wiki](https://github.com/UACalc/UACalc_CLI/wiki) (requires GitHub login). 

----------------------------------------------------

## References
[1] Ralph Freese and Matthew Valeriote, [On the complexity of some Maltsev conditions](http://www.math.hawaii.edu/~ralph/Preprints/IJAC_1901_P41.pdf), Intern. J. Algebra & Computation, 19(2009), 41-77.




