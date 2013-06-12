#!/usr/bin/python
import sys

if len(sys.argv) <= 1:
    print "Need to specify file"
    sys.exit(0)

found = False
linec = 0
for line in open(sys.argv[1],'r'):
    linec += 1
    if len(line) <= 1:
        continue

    if len(line[:-1]) != len(line[:-1].rstrip(' ')):
        print "Found trailing whitespace at line %d." % linec
        found = True

if not found:
    print "SUCCESS: No trailing whitespace found"
else:
    print "FAILURE: Fix trailing whitespace"
