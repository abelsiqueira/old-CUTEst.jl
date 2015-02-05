#!/usr/bin/env python

import os
import re

cutest = os.getenv('CUTEST', "")
if cutest is "":
    print("ERROR: Variable CUTEST not set. Verify your CUTEst installation.")
    exit(1)

functions = []
with open(cutest+"/include/cutest.h") as file:
    start_function = False
    for line in file:
        if start_function:
            function += " " + line.strip()
        if "void CUTEST" in line:
            start_function = True
            function = line.strip()
        if start_function and ";" in line:
            start_function = False
            functions.append(function)

for function in functions:
    name = re.search('CUTEST_([a-z]*)', function).group(1)
    print("function cutest_jl_"+name+" (", end="")
    args = re.search('\((.*)\)', function).group(1).split(',')
    print(', '.join(
        [re.search('\*(.*)', arg.strip()).group(1) for arg in args]
        )+")")
    for arg in args:
        match = re.search('([a-z]*) \*(.*)', arg.strip())
        t = match.group(1)
        var = match.group(2)
        print("    "+var+" = Array("+t+", 1)")
    print("    ccall((\""+name+"\", libname), Void,")
    print("        (", end="")
    print(', '.join(
        ["Ptr{"+re.search('([a-z]*) \*.*', arg.strip()).group(1)+"}"
            for arg in args]
        )+"),")
    print("        "+', '.join(
        [re.search('\*(.*)', arg.strip()).group(1) for arg in args]
        )+")")
    print("end")
