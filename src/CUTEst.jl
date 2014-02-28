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
    n::Int32
    # number of constraints
    m::Int32
    # nnz in Jacobian
    nnzj::Int32
    # nnz in upper triangular Hessian
    nnzh::Int32
    # derivative type
    dertype::Int32
    # array that gives the initial estimate of the solution of the problem
    x
    # array that gives lower bounds on the variables
    bl
    # array that gives upper bounds on the variables
    bu
    # array that gives the initial estimate of the Lagrange multipliers
    v
    # array that gives lower bounds on the inequality constraints
    cl
    # array that gives upper bounds on the inequality constraints
    cu
    # a logical array whose i-th component is 1 if the i-th constraint
    # is an equation
    equatn
    # a logical array whose i-th component is 1 if the i-th constraint
    # is  linear
    linear

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
    ccall(("fortran_open_", "libCUTEstJL.so"), Void,
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

    # Set variables dependent of the problem's size
    x = Array(Float64, n[1])
    bl = Array(Float64, n[1])
    bu = Array(Float64, n[1])
    v = Array(Float64, m[1])
    cl = Array(Float64, m[1])
    cu = Array(Float64, m[1])
    equatn = zeros(Int32, m[1])
    linear = zeros(Int32, m[1])

    if m[1] > 0
        # Set up data structure for constrained minimization.
        #
        # The order is unimportant.
        println("Using csetup")
        ccall(("cutest_csetup_", "libCUTEstJL.so"), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64},
                Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
                status, &funit, iout, &io_buffer,
                n, m, x, bl, bu,
                v, cl, cu, equatn, linear,
                &1, &0, &0)
    else
        println("Using usetup")
        ccall(("cutest_usetup_", "libCUTEstJL.so"), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                status, &funit, iout, &io_buffer,
                n, m, x, bl, bu)
    end

    # Closing file
    ccall(("fortran_close_", "libCUTEstJL.so"), Void,
            (Ptr{Int32}, Ptr{Int32}),
            &funit, ioErr)
    if ioErr[1] > 0
        throw(ErrorException("Problem when reading OUTSDIF.d"))
    end

    return CUTEstProb(n[1], m[1],
            0, 0, 0,
            x, bl, bu,
            v, cl, cu,
            equatn, linear)
end

end # module
