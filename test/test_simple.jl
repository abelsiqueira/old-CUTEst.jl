using CUTEst

CUTEst.buildProblem("HS35")
prob = CUTEst.loadProblem()

x = copy(prob.x)
status = [int32(0)]
f = [float64(0.0)]
c = Array(Float64, prob.m[1])
CUTEst.cfn(status, prob.n, prob.m, x, f, c)

println("x = ",x)
println("f = ",f)
println("c = ",c)

CUTEst.cterminate(status)
