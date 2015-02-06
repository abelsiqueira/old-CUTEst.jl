using CUTEst

push!(DL_LOAD_PATH,".")
CUTEst.buildCUTEstProb("HS35")
prob = CUTEst.loadCUTEstProb()

x = copy(prob.x)
status = [int32(0)]
f = [float64(0.0)]
c = Array(Float64, prob.m[1])
CUTEst.cfn(status, prob.n, prob.m, x, f, c)

println("x = ",x)
println("f = ",f)
println("c = ",c)
