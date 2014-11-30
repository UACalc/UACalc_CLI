'''Command line utilities for a command line session of Jython-UACalc.

Created on Jun 23, 2013
@see: AlgebraConstructionExample.py
@author: ralph at math.hawaii.edu, williamdemeo at gmail
'''

import sys
from os.path import expanduser


''' ATTENTION!!! 
    UACALC_CLI_ROOT must be set equal to the fully qualified name
    of the UACalc_CLI directory, that is, the directory containing:
    Algebras, Examples, and CLI subdirectories.
'''
UACALC_CLI_ROOT = expanduser("~/git/UACalc_CLI")


sys.path.append(UACALC_CLI_ROOT+"/CLI/Jars/uacalc.jar")
sys.path.append(UACALC_CLI_ROOT+"/CLI/Jars/LatDraw.jar")
sys.path.append(UACALC_CLI_ROOT+"/Examples")

import rlcompleter
import readline
readline.parse_and_bind("tab: complete")

from OperationFactory import Operation
from org.uacalc.alg import BasicAlgebra
from org.uacalc.io import AlgebraIO
from org.uacalc.alg import Malcev
from org.uacalc.alg.conlat import BasicPartition

print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
print "Welcome to the command line version of UACalc!"
print "  to exit type quit()"
print "  (more help coming)"
print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

