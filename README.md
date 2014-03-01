# CUTEst

**WARNING**: This is a work in progress.

Interface to [CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki/), a
Constrained and Unconstrained Testing Environment on steroids, from Dominique
Orban.

## Installation

- Install CUTEst

  C/Fortran "code to be called (from Julia) must be available as a shared
  library". Unfortunately the original CUTEst is only available as static
  library so you have to use [ugly](https://github.com/lpoo/ugly).

~~~
$ git clone --recursive --branch julia git://github.com/lpoo/ugly.git
$ cd ugly
$ ./configure --enable-shared
$ make
# make install
~~~

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
gfortran -fPIC -ffixed-form -c ELFUN.f90
gfortran -fPIC -ffixed-form -c GROUP.f90
gfortran -fPIC -ffixed-form -c RANGE.f90
~~~

- Load problem build previously.

~~~
julia> problem = loadCUTEstProb()
CUTEstProb("HS11      ",[2],[1],[4],[2],[4.9,0.1],["X1        ","X2        "],[-1.0e20,-1.0e20],[1.0e20,1.0e20],[0.0],["CON1      "],[0.0],[1.0e20],[0],[0])
~~~

- Evaluate the objective function and constraints for `problem.x`.

~~~
julia> f, c = evaluateCUTEstProb(problem)
([-24.979999999999997],[-23.910000000000004])
~~~

## Support

- [ ] `cutest_ccfg`
- [ ] `cutest_ccfsg`
- [ ] `cutest_ccifg`
- [ ] `cutest_ccifsg`
- [ ] `cutest_cdh`
- [x] `cutest_cdimen`
- [ ] `cutest_cdimse`
- [x] `cutest_cdimsh`
- [x] `cutest_cdimsj`
- [ ] `cutest_ceh`
- [x] `cutest_cfn`
- [ ] `cutest_cgrdh`
- [ ] `cutest_cgr`
- [ ] `cutest_chcprod`
- [ ] `cutest_chprod`
- [ ] `cutest_cidh`
- [ ] `cutest_cish`
- [ ] `cutest_cjprod`
- [ ] `cutest_clfg`
- [x] `cutest_cnames`
- [ ] `cutest_cofg`
- [ ] `cutest_cofsg`
- [ ] `cutest_connames`
- [ ] `cutest_creport`
- [x] `cutest_csetup`
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
- [x] `cutest_unames`
- [ ] `cutest_uofg`
- [ ] `cutest_ureport`
- [x] `cutest_usetup`
- [ ] `cutest_ush`
- [ ] `cutest_ushp`
- [ ] `cutest_uvartype`
- [ ] `cutest_varnames`
