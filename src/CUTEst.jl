module CUTEst

# package code goes here

# CUTEst filename
fName = "OUTSDIF.d"
# FORTRAN unit number for OUTSDIF.d
funit = 42
# FORTRAN unit number for error output
iout = 6
# Exit flag from OPEN and CLOSE
ioErr = 0
# FORTRAN unit internal input/output
io_buffer = 11
# Exit flag from CUTEst tools
status = 0

type CUTEstProb
    # number of variables
    nvar::Int
    # number of constraints
    ncon::Int
    # nnz in Jacobian
    nnzj::Int
    # nnz in upper triangular Hessian
    nnzh::Int
    # derivative type
    dertype::Int
end

function buildCUTEstProb(prob_name)
    run(`runcutest -p gen77 -D $prob_name`)
end

function loadCUTEstProb()
    ioErr = 0
    status = 0
    n = zeros(Int32, 1)
    m = zeros(Int32, 1)
    fName = "OUTSDIF.d"
    funit = 42

    ccall(("fortran_open_",
           "libCUTEstJL.so"),
          Ptr{Int32}, (Ptr{Int32}, Ptr{Uint8}, Ptr{Int32}), &funit, fName, &ioErr)
    ccall(("cutest_cdimen_",
           "libCUTEstJL.so"),
          Ptr{Int32}, (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}), &status, &funit, n, m)
    return n, m
end

end # module
