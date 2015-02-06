const libname = "libCUTEstJL.so"

function cutest_jl_usetup (status, funit, iout, io_buffer, n, x, bl, bu)
    ccall(("usetup", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
        status, funit, iout, io_buffer, n, x, bl, bu)
end

function cutest_jl_csetup (status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn, linear, e_order, l_order, v_order)
    ccall(("csetup", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, funit, iout, io_buffer, n, m, x, bl, bu, v, cl, cu, equatn, linear, e_order, l_order, v_order)
end

function cutest_jl_udimen (status, funit, n)
    ccall(("udimen", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, funit, n)
end

function cutest_jl_udimsh (status, nnzh)
    ccall(("udimsh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}),
        status, nnzh)
end

function cutest_jl_udimse (status, ne, nzh, nzirnh)
    ccall(("udimse", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, ne, nzh, nzirnh)
end

function cutest_jl_uvartype (status, n, ivarty)
    ccall(("uvartype", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, n, ivarty)
end

function cutest_jl_unames (status, n, pname, vnames)
    ccall(("unames", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}, Ptr{Uint8}),
        status, n, pname, vnames)
end

function cutest_jl_ureport (status, calls, time)
    ccall(("ureport", libname), Void,
        (Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
        status, calls, time)
end

function cutest_jl_cdimen (status, funit, n, m)
    ccall(("cdimen", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, funit, n, m)
end

function cutest_jl_cdimsj (status, nnzj)
    ccall(("cdimsj", libname), Void,
        (Ptr{Int32}, Ptr{Int32}),
        status, nnzj)
end

function cutest_jl_cdimsh (status, nnzh)
    ccall(("cdimsh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}),
        status, nnzh)
end

function cutest_jl_cdimse (status, ne, nzh, nzirnh)
    ccall(("cdimse", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, ne, nzh, nzirnh)
end

function cutest_jl_cstats (status, nonlinear_variables_objective, nonlinear_variables_constraints, equality_constraints, linear_constraints)
    ccall(("cstats", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, nonlinear_variables_objective, nonlinear_variables_constraints, equality_constraints, linear_constraints)
end

function cutest_jl_cvartype (status, n, ivarty)
    ccall(("cvartype", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, n, ivarty)
end

function cutest_jl_cnames (status, n, m, pname, vnames, gnames)
    ccall(("cnames", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}, Ptr{Uint8}, Ptr{Uint8}),
        status, n, m, pname, vnames, gnames)
end

function cutest_jl_creport (status, calls, time)
    ccall(("creport", libname), Void,
        (Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
        status, calls, time)
end

function cutest_jl_connames (status, m, gname)
    ccall(("connames", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}),
        status, m, gname)
end

function cutest_jl_pname (status, funit, pname)
    ccall(("pname", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}),
        status, funit, pname)
end

function cutest_jl_probname (status, pname)
    ccall(("probname", libname), Void,
        (Ptr{Int32}, Ptr{Uint8}),
        status, pname)
end

function cutest_jl_varnames (status, n, vname)
    ccall(("varnames", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Uint8}),
        status, n, vname)
end

function cutest_jl_ufn (status, n, x, f)
    ccall(("ufn", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
        status, n, x, f)
end

function cutest_jl_ugr (status, n, x, g)
    ccall(("ugr", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}),
        status, n, x, g)
end

function cutest_jl_uofg (status, n, x, f, g, grad)
    ccall(("uofg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
        status, n, x, f, g, grad)
end

function cutest_jl_ubandh (status, n, x, nsemib, bandh, lbandh, maxsbw)
    ccall(("ubandh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, x, nsemib, bandh, lbandh, maxsbw)
end

function cutest_jl_udh (status, n, x, lh1, h)
    ccall(("udh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}),
        status, n, x, lh1, h)
end

function cutest_jl_ush (status, n, x, nnzh, lh, h, irnh, icnh)
    ccall(("ush", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, x, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_ueh (status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
    ccall(("ueh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, x, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
end

function cutest_jl_ugrdh (status, n, x, g, lh1, h)
    ccall(("ugrdh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}),
        status, n, x, g, lh1, h)
end

function cutest_jl_ugrsh (status, n, x, g, nnzh, lh, h, irnh, icnh)
    ccall(("ugrsh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, x, g, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_ugreh (status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
    ccall(("ugreh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, x, g, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
end

function cutest_jl_uhprod (status, n, goth, x, p, q)
    ccall(("uhprod", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
        status, n, goth, x, p, q)
end

function cutest_jl_cfn (status, n, m, x, f, c)
    ccall(("cfn", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
        status, n, m, x, f, c)
end

function cutest_jl_cofg (status, n, x, f, g, grad)
    ccall(("cofg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
        status, n, x, f, g, grad)
end

function cutest_jl_cofsg (status, n, x, f, nnzg, lg, sg, ivsg, grad)
    ccall(("cofsg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, x, f, nnzg, lg, sg, ivsg, grad)
end

function cutest_jl_ccfg (status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
    ccall(("ccfg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, m, x, c, jtrans, lcjac1, lcjac2, cjac, grad)
end

function cutest_jl_clfg (status, n, m, x, v, f, g, grad)
    ccall(("clfg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
        status, n, m, x, v, f, g, grad)
end

function cutest_jl_cgr (status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
    ccall(("cgr", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}),
        status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac)
end

function cutest_jl_csgr (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun)
    ccall(("csgr", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun)
end

function cutest_jl_ccfsg (status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
    ccall(("ccfsg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}),
        status, n, m, x, c, nnzj, lcjac, cjac, indvar, indfun, grad)
end

function cutest_jl_ccifg (status, n, i, x, ci, gci, grad)
    ccall(("ccifg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
        status, n, i, x, ci, gci, grad)
end

function cutest_jl_ccifsg (status, n, i, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
    ccall(("ccifsg", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, i, x, ci, nnzsgc, lsgci, sgci, ivsgci, grad)
end

function cutest_jl_cgrdh (status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
    ccall(("cgrdh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}),
        status, n, m, x, v, grlagf, g, jtrans, lcjac1, lcjac2, cjac, lh1, h)
end

function cutest_jl_cdh (status, n, m, x, v, lh1, h)
    ccall(("cdh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}),
        status, n, m, x, v, lh1, h)
end

function cutest_jl_csh (status, n, m, x, v, nnzh, lh, h, irnh, icnh)
    ccall(("csh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, m, x, v, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_cshc (status, n, m, x, v, nnzh, lh, h, irnh, icnh)
    ccall(("cshc", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, m, x, v, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_ceh (status, n, m, x, lv, v, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
    ccall(("ceh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, m, x, lv, v, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
end

function cutest_jl_cidh (status, n, x, iprob, lh1, h)
    ccall(("cidh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}),
        status, n, x, iprob, lh1, h)
end

function cutest_jl_cish (status, n, x, iprob, nnzh, lh, h, irnh, icnh)
    ccall(("cish", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, x, iprob, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_csgrsh (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh, lh, h, irnh, icnh)
    ccall(("csgrsh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}),
        status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun, nnzh, lh, h, irnh, icnh)
end

function cutest_jl_csgreh (status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
    ccall(("csgreh", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, m, x, v, grlagf, nnzj, lcjac, cjac, indvar, indfun, ne, le, iprnhi, iprhi, lirnhi, irnhi, lhi, hi, byrows)
end

function cutest_jl_chprod (status, n, m, goth, x, v, p, q)
    ccall(("chprod", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
        status, n, m, goth, x, v, p, q)
end

function cutest_jl_chcprod (status, n, m, goth, x, v, p, q)
    ccall(("chcprod", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
        status, n, m, goth, x, v, p, q)
end

function cutest_jl_cjprod (status, n, m, gotj, jtrans, x, p, lp, r, lr)
    ccall(("cjprod", libname), Void,
        (Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
        status, n, m, gotj, jtrans, x, p, lp, r, lr)
end
