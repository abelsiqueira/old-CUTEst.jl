# CUTEst

**WARNING**: This is a work in progress.

Interface to [CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki/), a
Constrained and Unconstrained Testing Environment on steroids, from Dominique
Orban.

## Installation

- Install CUTEst

  The original interface for C and Fortran.
  You need to install it completely and set the environment variables
  `CUTEST`, `SIFDECODE`, `MYARCH`, `MASTSIF`
  as well as include the path to the binaries.
  You do not need interface to Matlab, nor GALAHAD, neither need to
  make any modifications on the commands for the compilers.
  If you don't want to do this yourself, you can go to
  [cutest-julia-installer](http://github.com/abelsiqueira/cutest-julia-installer)
  and do most of the work automatically.

- Build and install the shared library from cutest.
  
  Basically, you need most tools from `$CUTEST/src/tools`
  compiled with `-fPIC`,
  the module `cutest.mod` from `$CUTEST/modules/$MYARCH/double/`,
  link everything to a `libcutest.so` and copy it to somewhere
  visible by ld (such as `/usr/lib/`).
  To avoid doing this yourself, go to
  [cutest-julia-installer](http://github.com/abelsiqueira/cutest-julia-installer)

- Install this package.

~~~
julia> Pkg.clone("git://github.com/lpoo/CUTEst.jl.git")
~~~

## Using (Demo)

- Starting Julia with current working directory in `LD_LIBRARY_PATH`.

~~~
$ LD_LIBRARY_PATH=./ julia
~~~

- Load CUTEst

~~~
julia> using CUTEst
~~~

- Build the shared library for wanted problem (this is CUTEst's inheritance).

~~~
julia> buildCUTEstProb("HS11")
sifdecoder -A pc64.lnx.gfo  HS11

 Problem name: HS11

 Double precision version will be formed

 The objective function uses 1 nonlinear group

 There is 1 nonlinear inequality constraint

 There are 2 free variables


 File successfully decoded
~~~

- Load problem build previously.

~~~
julia> problem = loadCUTEstProb()
CUTEstProb("HS11      ",[2],[1],[4],[2],[4.9,0.1],["X1        ","X2        "],[-1.0e20,-1.0e20],[1.0e20,1.0e20],[0.0],["CON1      "],[0.0],[1.0e20],[0],[0])
~~~

  From here, you can verify that the function was loaded,
  the bounds are correct, the names are correct,
  the initial value is correct and the dimensions are correct.
  Support for each function will follow shortly.

## Support

Each of the following functions should be translated into
an equivalent julia call.
The names shall follow the change of pattern
`cutest_xx_` to `cutest_jl_xx`, and the same input and
output should be used.
In additions, some additional higher level functions
should be created, that should be used only when speed
is not a factor.
Since this is mostly not the case with NLP, they will
be secondary.

The following list is an initial preview of which functions will
be translated.

- [ ] `cutest_ccfg`
- [ ] `cutest_ccfsg`
- [ ] `cutest_ccifg`
- [ ] `cutest_ccifsg`
- [ ] `cutest_cdh`
- [ ] `cutest_cdimen`
- [ ] `cutest_cdimse`
- [ ] `cutest_cdimsh`
- [ ] `cutest_cdimsj`
- [ ] `cutest_ceh`
- [ ] `cutest_cfn`
- [ ] `cutest_cgrdh`
- [ ] `cutest_cgr`
- [ ] `cutest_chcprod`
- [ ] `cutest_chprod`
- [ ] `cutest_cidh`
- [ ] `cutest_cish`
- [ ] `cutest_cjprod`
- [ ] `cutest_clfg`
- [ ] `cutest_cnames`
- [ ] `cutest_cofg`
- [ ] `cutest_cofsg`
- [ ] `cutest_connames`
- [ ] `cutest_creport`
- [ ] `cutest_csetup`
- [ ] `cutest_csgreh`
- [ ] `cutest_csgr`
- [ ] `cutest_csgrsh`
- [ ] `cutest_cshc`
- [ ] `cutest_csh`
- [ ] `cutest_cshp`
- [ ] `cutest_cvartype`
- [ ] `cutest_probname`
- [ ] `cutest_ubandh`
- [ ] `cutest_udh`
- [ ] `cutest_udimen`
- [ ] `cutest_udimse`
- [ ] `cutest_udimsh`
- [ ] `cutest_ueh`
- [ ] `cutest_ufn`
- [ ] `cutest_ugrdh`
- [ ] `cutest_ugreh`
- [ ] `cutest_ugr`
- [ ] `cutest_ugrsh`
- [ ] `cutest_uhprod`
- [ ] `cutest_unames`
- [ ] `cutest_uofg`
- [ ] `cutest_ureport`
- [ ] `cutest_usetup`
- [ ] `cutest_ush`
- [ ] `cutest_ushp`
- [ ] `cutest_uvartype`
- [ ] `cutest_varnames`
