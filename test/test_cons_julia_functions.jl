using CUTEst

CUTEst.buildProblem("HS35")
prob = CUTEst.loadProblem()

x = prob.x
f = CUTEst.objFun(prob, x)
g = CUTEst.objGrad(prob, x)
c = CUTEst.constr(prob, x)
println("f = ", f)
println("g = ", g)
println("c = ", c)

CUTEst.terminate(prob)
