module CUTEst

# Global definitions
#
# This definitions comes from CUTEst.
#
# They are all vectors to avoid erros when using `ccall`.

# CUTEst filename
const fName = "OUTSDIF.d"
# FORTRAN unit number for OUTSDIF.d
const funit = [int32(42)]
# FORTRAN unit number for error output
const iout = [int32(6)]
# Exit flag from OPEN and CLOSE
ioErr = Array(Int32, 1)
# FORTRAN unit internal input/output
const io_buffer = [int32(11)]
# Exit flag from CUTEst tools
status = Array(Int32, 1)
# If the user wishes the general equations to occur before the general
# inequalities in the list of constraints, e_order must be set to 1.  If  the
# general  equations  should  follow  the  general inequalities,  e_order must be
# set to 2. If the order is unimportant, e_order should be set to 0; any value
# except 1 and 2 will be interpreted as 0,
const e_order = [int32(0)]
# If the user wishes the general linear (or affine) constraints to occur before
# the general nonlin‐ ear ones in the list of constraints, l_order must be set to
# 1.  If the general linear constraints should follow the general nonlinear ones,
# l_order must be set to 2. If the order is  unimportant, l_order should be set
# to 0; any value except 1 and 2 will be interpreted as 0,
const l_order = [int32(0)]
# If the user wishes the nonlinear variables to occur before those that only
# appear linearly in the problem, in the list of variables, v_order must be set
# to 1; within the nonlinear  variables  the smaller  set of either the nonlinear
# objective or nonlinear Jacobian variables will appear first.  If the nonlinear
# variables must follow the linear ones, v_order should be set to 2. If the
# order is unimportant, v_order should be set to 0; any value except 1 and 2 will
# be interpreted as 0.
const v_order = [int32(0)]

# Type definitions

# CUTEstProb
#
# Store all the information about a problem and will be setup
# by loadCUTEstProb.
type CUTEstProb
    # name of the problem
    pname::ASCIIString
    # number of variables
    n::Array{Int32, 1}
    # number of constraints
    m::Array{Int32, 1}
    # nnz in Jacobian
    nnzj::Int32
    # nnz in upper triangular Hessian
    nnzh::Int32
    # derivative type
    dertype::Int32
    # array that gives the initial estimate of the solution of the problem
    x::Array{Float64, 1}
    # array that gives the name of the variables
    vnames::Array{ASCIIString, 1}
    # array that gives lower bounds on the variables
    bl::Array{Float64, 1}
    # array that gives upper bounds on the variables
    bu::Array{Float64, 1}
    # array that gives the initial estimate of the Lagrange multipliers
    v::Array{Float64, 1}
    # array that gives the name of the constrains
    cnames::Array{ASCIIString, 1}
    # array that gives lower bounds on the inequality constraints
    cl::Array{Float64, 1}
    # array that gives upper bounds on the inequality constraints
    cu::Array{Float64, 1}
    # a logical array whose i-th component is 1 if the i-th constraint
    # is an equation
    equatn::Array{Int32, 1}
    # a logical array whose i-th component is 1 if the i-th constraint
    # is  linear
    linear::Array{Int32, 1}
end

# Function definitions

# Private functions

function names2array(names::ASCIIString, size::Int32, number::Int32)
    array = Array(ASCIIString, number)

    for i = 1:number
        array[i] = names[(i - 1) * size + 1:i * size]
    end

    return array
end

# Public functions

export buildCUTEstProb, loadCUTEstProb

# Create the shared library to be used.
function buildCUTEstProb(prob_name)
    # TODO Replace `runcutest` with another call
    run(`runcutest -p gen77 -D $prob_name`)
end

# Setup the data structure with all the information about the problem.
function loadCUTEstProb()
    # Variables that store problems information.
    #
    # They must be a array because otherwise their values won't change
    # when calling CUTEst functions.
    n = Array(Int32, 1)
    m = Array(Int32, 1)

    # Open file
    if ~ isfile("OUTSDIF.d")
        throw(ErrorException("File OUTSDIF.d not exist"))
    end
    ioErr[1] = 0
    ccall(("fortran_open_", "libCUTEstJL.so"), Void,
            (Ptr{Int32}, Ptr{Uint8}, Ptr{Int32}),
            funit, fName, ioErr)
    if ioErr[1] > 0
        throw(ErrorException("Problem when reading OUTSDIF.d"))
    end

    # Get size of the problem
    ioErr[1] = 0
    ccall(("cutest_cdimen_", "libCUTEstJL.so"), Void,
            (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
            status, funit, n, m)
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
    equatn = Array(Int32, m[1])
    linear = Array(Int32, m[1])

    if m[1] > 0
        # Set up data structure for constrained minimization.
        ccall(("cutest_csetup_", "libCUTEstJL.so"), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64},
                Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
                status, funit, iout, io_buffer,
                n, m, x, bl, bu,
                v, cl, cu, equatn, linear,
                e_order, l_order, v_order)
    else
        # Set up data structure for unconstrained minimization.
        ccall(("cutest_usetup_", "libCUTEstJL.so"), Void,
                (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32},
                Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
                status, funit, iout, io_buffer,
                n, x, bl, bu)
    end
    if status[1] > 0
        throw(ErrorException("Problem when running setup"))
    end

    # Set variables for names
    pname = ^(" ", 10)
    tmp_vnames = ^(" ", 10 * n[1])
    tmp_cnames = ^(" ", 10 * m[1])

    status[1] = 0
    # Set up name of the problem and its variables
    if m[1] > 0
        ccall(("cutest_cnames_", "libCUTEstJL.so"), Void,
                (Ptr{Int32},
                Ptr{Int32}, Ptr{Int32},
                Ptr{Uint8}, Ptr{Uint8}, Ptr{Uint8}),
                status,
                n, m,
                pname, tmp_vnames, tmp_cnames)
    else
        # Set up data structure for unconstrained minimization.
        ccall(("cutest_unames_", "libCUTEstJL.so"), Void,
                (Ptr{Int32},
                Ptr{Int32},
                Ptr{Uint8}, Ptr{Uint8}),
                status,
                n,
                pname, tmp_vnames)
    end
    if status[1] > 0
        throw(ErrorException("Problem when running setup"))
    end
    vnames = names2array(tmp_vnames, int32(10), n[1])
    cnames = names2array(tmp_cnames, int32(10), m[1])

    # Closing file
    ioErr[1] = 0
    ccall(("fortran_close_", "libCUTEstJL.so"), Void,
            (Ptr{Int32}, Ptr{Int32}),
            funit, ioErr)
    if ioErr[1] > 0
        throw(ErrorException("Problem when closing OUTSDIF.d"))
    end

    return CUTEstProb(pname,
            n, m,
            0, 0, 0,
            x, vnames, bl, bu,
            v, cnames, cl, cu,
            equatn, linear)
end

end # module
