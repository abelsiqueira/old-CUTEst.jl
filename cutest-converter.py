#!/usr/bin/env python

import os
import re

# Type conversion
cutypes = {"integer":"Int32", "doublereal":"Float64", "logical":"Int32",
        "char":"Uint8"}

cutest = os.getenv('CUTEST', "")
if cutest is "":
    print("ERROR: Variable CUTEST not set. Verify your CUTEst installation.")
    exit(1)

# The function definitions are being read from the C include file.
# This should probably be improved to obtain more information about the
# functions, but this is easier.
functions = []
with open(cutest+"/include/cutest.h") as file:
    # Each new function starts with
    # void CUTEST_xxx
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

print("const libname = \"libCUTEstJL.so\"\n") 
s="    "
for function in functions:
    # Get function name
    name = re.search('CUTEST_([a-z]*)', function).group(1)
    # Get function arguments
    args = re.search('\((.*)\)', function).group(1).split(',')
    matches = [re.search('([a-z]*) \*(.*)', arg.strip()) for arg in args]
    # Create a list of [type,variable name]
    vars = [[m.group(1),m.group(2)] for m in matches]

    print("function "+name+" ("+', '.join([v[1] for v in vars])+")")
    print(s+"ccall((\"cutest_"+name+"_\", libname), Void,")
    if len(vars) == 1:
        print(s+s+"(Ptr{"+cutypes[vars[0][0]]+"},),")
    else:
        print(s+s+"("+', '.join(["Ptr{"+cutypes[v[0]]+"}" for v in vars])+"),")
    print(s+s+', '.join([v[1] for v in vars]) + ")")
    print("end\n")
