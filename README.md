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
$ git clone --recursive git://github.com/lpoo/ugly.git
$ cd ugly
$ ./configure --enable-shared
$ make
# make install
~~~

- Install this package.

~~~
julia> Pkg.clone("git://github.com/lpoo/CUTEst.jl.git")
~~~

## Using

- Starting Julia with current working directory in `LD_LIBRARY_PATH`.

~~~
LD_LIBRARY_PATH=./ julia
~~~

- Load CUTEst


~~~
julia> using CUTEst
~~~

- Build the shared library for wanted problem (this is CUTEst's inheritance).

~~~
julia> CUTEst.buildCUTEstProb("problem_name")
~~~

- Load problem build previously.

~~~
julia> CUTEst.loadCUTEstProb()
~~~
