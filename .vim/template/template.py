#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © %YEAR% %USER% <%MAIL%>
#
# Distributed under terms of the %LICENSE% license.

import sys
import time

def loadCSV(fn,header=False,DELIM="|"):
    f = open(fn, "r")
    headerLine = None
    if header:
        headerLine = f.read().strip().split(DELIM)
    lines = map(str.strip, f.read().strip().split("\n"))
    f.close()

    data = []

    for line in lines:
        if line!="":
            parts = line.split(DELIM)
            if headerLine!=None:
                assert len(parts) == len(headerLine)
            data.append(parts)
    return data


def main():
    print "Starting"
    startTime = float(time.time())

    %HERE%

    print "Finished in %0.4f seconds" % (time.time() - startTime)


if __name__ == "__main__":
    main()
