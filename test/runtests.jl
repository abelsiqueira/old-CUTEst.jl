tests = ["basic_test", "test_unc_julia_functions", "test_cons_julia_functions"]
for test in tests
    run(`julia test/$test.jl`)
end
