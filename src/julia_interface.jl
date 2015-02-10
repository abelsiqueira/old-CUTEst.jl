include("cutest_functions.jl")

function objFun(prob, x)
    st = [int32(-1)]
    f = [0.0]
    if prob.m[1] > 0
        c = Array(Float64,prob.m[1])
        cfn(st, prob.n, prob.m, x, f, c)
    else
        ufn(st, prob.n, x, f)
    end
    return f
end

function objGrad(prob, x)
    st = [int32(-1)]
    f = [0.0]
    g = Array(Float64, prob.n[1])
    grad = [int32(1)]
    if prob.m[1] > 0
        cofg(st, prob.n, x, f, g, grad)
    else
        uofg(st, prob.n, x, f, g, grad)
    end
    return g
end

function objHprod(prob, x, v)
    st = [int32(-1)]
    goth = [int32(0)]
    Hv = Array(Float64, prob.n[1])
    if prob.m[1] > 0
        y = zeros(prob.m[1])
        chprod(st, prob.n, prob.m, goth, x, y, v, Hv)
    else
        uhprod(st, prob.n, goth, x, v, Hv)
    end
    return Hv
end

function lagrHprod(prob, x, y, v)
    st = [int32(-1)]
    goth = [int32(0)]
    Hv = Array(Float64, prob.n[1])
    if prob.m[1] > 0
        chprod(st, prob.n, prob.m, goth, x, y, v, Hv)
    else
        uhprod(st, prob.n, goth, x, v, Hv)
    end
    return Hv
end

function objHess(prob, x)
    st = [int32(-1)]
    nnzh = [int32(0)]
    Hv = Array(Float64, prob.nnzh[1])
    Hi = Array(Int32, prob.nnzh[1])
    Hj = Array(Int32, prob.nnzh[1])
    if prob.m[1] > 0
        y = zeros(prob.m[1])
        csh(st, prob.n, prob.m, x, y, nnzh, prob.nnzh, Hv, Hi, Hj)
    else
        ush(st, prob.n, x, nnzh, prob.nnzh, Hv, Hi, Hj)
    end
    H = zeros(prob.n[1], prob.n[1])
    for k = 1:nnzh[1]
        i = Hi[k]
        j = Hj[k]
        H[i,j] = Hv[k]
        H[j,i] = Hv[k]
    end
    return H
end

function lagrHess(prob, x, y)
    st = [int32(-1)]
    nnzh = [int32(0)]
    Hv = Array(Float64, prob.nnzh[1])
    Hi = Array(Int32, prob.nnzh[1])
    Hj = Array(Int32, prob.nnzh[1])
    if prob.m[1] > 0
        csh(st, prob.n, prob.m, x, y, nnzh, prob.nnzh, Hv, Hi, Hj)
    else
        ush(st, prob.n, x, nnzh, prob.nnzh, Hv, Hi, Hj)
    end
    H = zeros(prob.n[1], prob.n[1])
    for k = 1:nnzh[1]
        i = Hi[k]
        j = Hj[k]
        H[i,j] = Hv[k]
        H[j,i] = Hv[k]
    end
    return H
end

function constr(prob, x)
    if prob.m[1] == 0
        return []
    end
    st = [int32(-1)]
    f = [0.0]
    c = Array(Float64, prob.m[1])
    cfn(st, prob.n, prob.m, x, f, c)
    return c
end

function jacob(prob, x)
    if prob.m[1] == 0
        return []
    end
    st = [int32(-1)]
    c = Array(Float64, prob.m[1])
    nnzj = [int32(0)]
    Jv = Array(Float64, prob.nnzj[1])
    Ji = Array(Int32, prob.nnzj[1])
    Jj = Array(Int32, prob.nnzj[1])
    grad = [int32(1)]
    ccfsg(st, prob.n[1], prob.m[1], x, c, nnzj, prob.nnzj[1], Jv, Ji, Jj, grad)
    J = zeros(prob.m[1], prob.n[1])
    for k = 1:nnzj[1]
        J[Ji[k],Jj[k]] = Jv[k]
    end
    return J
end

function jprod(prob, x, trans, v)
    if prob.m[1] == 0
        return []
    end
    st = [int32(-1)]
    gotj = [int32(0)]
    jtrans = [int32(trans)]
    if trans
        lv = prob.m
        lr = prob.n
    else
        lv = prob.n
        lr = prob.m
    end
    r = Array(Float64, lr[1])
    cjprod(st, prob.n[1], prob.m[1], gotj, jtrans, x, v, lv, r, lr)
    return r
end

function terminate(prob)
    st = [int32(-1)]
    if prob.m[1] > 0
        cterminate(st)
    else
        uterminate(st)
    end
end
