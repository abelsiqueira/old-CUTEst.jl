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
  **One easy way to do that is using
  [Homebrew/Linuxbrew](https://github.com/dpo/homebrew-cutest),
  which will provides all that, and a shared library, which you'll need.**
  You do not need interface to Matlab, nor GALAHAD, neither need to
  make any modifications on the commands for the compilers.
  If you don't want to do this yourself, you can go to
  [cutest-julia-installer](http://github.com/abelsiqueira/cutest-julia-installer)
  and do most of the work automatically.

- Build and install the shared library from cutest.

  **If you used Homebrew/Linuxbrew, you already have a shared library,
  and can skip this step.**
  Basically, you need most tools from `$CUTEST/src/tools`
  compiled with `-fPIC`,
  the module `cutest.mod` from `$CUTEST/modules/$MYARCH/double/`,
  link everything to a `libcutest.so` and copy it to somewhere
  visible by ld (such as `/usr/lib/`).
  To avoid doing this yourself, go to
  [cutest-julia-installer](http://github.com/abelsiqueira/cutest-julia-installer)

- Install this package.

~~~
julia> Pkg.clone("git://github.com/abelsiqueira/CUTEst.jl.git")
~~~

## Using (Demo)

- Load CUTEst

~~~
julia> using CUTEst
~~~

- Build the shared library for specific problem (this is CUTEst's inheritance).

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

- Load problem built previously.

~~~
julia> problem = loadCUTEstProb()
CUTEstProb("HS11      ",[2],[1],[4],[2],[4.9,0.1],["X1        ","X2        "],[-1.0e20,-1.0e20],[1.0e20,1.0e20],[0.0],["CON1      "],[0.0],[1.0e20],[0],[0])
~~~

  From here, you can verify that the function was loaded,
  the bounds are correct, the names are correct,
  the initial value is correct and the dimensions are correct.

- Test cfn

~~~
julia> f = [0.0];
julia> c = Array(Float64, prob.m[1]);
julia> st = [int32(0)];
julia> x = copy(prob.x);
julia> CUTEst.cfn(st, prob.n, prob.m, x, f, c)
julia> println("f = ",f)
f = [-24.979999999999997]
julia> println("c = ",c)
c = [-23.910000000000004]
~~~

## Interface

Each of the `cutest_cxxx` and `cutest_uxxx` functions should be translated into
an equivalent julia call.
The names shall follow the change of pattern
`cutest_xx_` to `xx`, for it will be implied
`CUTEst.xx`. The same input and
output should be used.
In additions, some additional higher level functions
should be created, that should be used only when speed
is not a factor.
Since this is mostly not the case with NLP, they will
be secondary.
