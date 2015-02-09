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

function constr(prob, x)
  if prob.m[1] == 0
    return []
  end
  st = [int32(-1)]
  f = [0.0]
  c = Array(Float64,prob.m[1])
  cfn(st, prob.n, prob.m, x, f, c)
  return c
end

function terminate(prob)
  st = [int32(-1)]
  if prob.m[1] > 0
    cterminate(st)
  else
    uterminate(st)
  end
end
