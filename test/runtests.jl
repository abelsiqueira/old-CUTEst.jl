using CUTEst

push!(DL_LOAD_PATH,".")
CUTEst.buildCUTEstProb("HS35")
prob = CUTEst.loadCUTEstProb()

println(prob.x)
