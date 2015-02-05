using CUTEst

CUTEst.buildCUTEstProb("HS35")
prob = CUTEst.loadCUTEstProb()

println(prob.x)
