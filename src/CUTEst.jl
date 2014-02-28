module CUTEst

export loadCUTEstProb

# Global definitions
#
# This definitions comes from CUTEst.

# CUTEst filename
fName = "OUTSDIF.d"
# FORTRAN unit number for OUTSDIF.d
funit = 42
# FORTRAN unit number for error output
iout = 6
# Exit flag from OPEN and CLOSE
ioErr = zeros(Int32, 1)
# FORTRAN unit internal input/output
io_buffer = 11
# Exit flag from CUTEst tools
status = zeros(Int32, 1)

# Type definitions

# CUTEstProb
#
# Store all the information about a problem and will be setup
# by loadCUTEstProb.
type CUTEstProb
    # number of variables
    n::Int
    # number of constraints
    m::Int
    # nnz in Jacobian
    nnzj::Int
    # nnz in upper triangular Hessian
    nnzh::Int
    # derivative type
    dertype::Int
end

# Create the shared library to be used.
function buildCUTEstProb(prob_name)
    run(`runcutest -p gen77 -D $prob_name`)
end

# Setup the data structure with all the information about the problem.
function loadCUTEstProb()
    # Variables that store problems information.
    #
    # They must be a array because otherwise their values won't change
    # when calling CUTEst functions.
    n = zeros(Int32, 1)
    m = zeros(Int32, 1)

    # Open file
    if ~ isfile("OUTSDIF.d")
        throw(ErrorException("File OUTSDIF.d not exist"))
    end
    ccall(("fortran_open_", "libCUTEstJL.so"), Ptr{Int32},
            (Ptr{Int32}, Ptr{Uint8}, Ptr{Int32}),
            &funit, fName, ioErr)
    if ioErr[1] > 0
        throw(ErrorException("Problem when reading OUTSDIF.d"))
    end

    # Get size of the problem
    ccall(("cutest_cdimen_", "libCUTEstJL.so"), Void,
            (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
            status, &funit, n, m)
    if ioErr[1] > 0
        throw(ErrorException("Error when retrieve size"))
    end

    return CUTEstProb(n[1], m[1], 0, 0, 0)
end

end # module
