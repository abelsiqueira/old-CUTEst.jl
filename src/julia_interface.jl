include("cutest_functions.jl")

function obj_fun(prob, x)
  st = [int32(-1)]
  f = [0.0]
  if prob.m[1] > 0
    c = Array(Float64,prob.m[1])
    cfn(st, prob.n, prob.m, x, f, c)
  else
    ufn(st, prob.n, x, f)
  end
end
