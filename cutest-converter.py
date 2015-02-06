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

cutypes = {"integer":"Int32", "doublereal":"Float64", "logical":"Int32",
        "char":"Uint8"}

print("const libname = \"libCUTEstJL.so\"\n") 
for function in functions:
    name = re.search('CUTEST_([a-z]*)', function).group(1)
    print("function cutest_jl_"+name+" (", end="")
    args = re.search('\((.*)\)', function).group(1).split(',')
    matches = [re.search('([a-z]*) \*(.*)', arg.strip()) for arg in args]
    vars = [[m.group(1),m.group(2)] for m in matches]
    print(', '.join([v[1] for v in vars]) + ")")
    print("    ccall((\"cutest_"+name+"_\", libname), Void,")
    print("        (", end="")
    print(', '.join(["Ptr{"+cutypes[v[0]]+"}" for v in vars])+"),")
    print("        "+', '.join([v[1] for v in vars]) + ")")
    print("end\n")
