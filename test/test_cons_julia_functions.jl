using CUTEst

CUTEst.buildProblem("HS39")
prob = CUTEst.loadProblem()

x = prob.x
f = CUTEst.objFun(prob, x)
g = CUTEst.objGrad(prob, x)
c = CUTEst.constr(prob, x)
H = CUTEst.objHess(prob, x)
W = CUTEst.lagrHess(prob, x, c)
Hg = CUTEst.objHprod(prob, x, g)
Wg = CUTEst.lagrHprod(prob, x, c, g)

println("f = ", f)
println("g = ", g)
println("c = ", c)
println("|Hg - H*g| = ", norm(Hg-H*g))
println("|Wg - W*g| = ", norm(Wg-W*g))

CUTEst.terminate(prob)
