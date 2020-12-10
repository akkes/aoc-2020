using DelimitedFiles
using BenchmarkTools

function product_of_year_sum(matrix::Array{Int})
    for items in Iterators.product(matrix, matrix)
        a, b = items
        if a + b == 2020
            return a * b
        end
    end
end

function product_product_of_year_sum(matrix::Array{Int})
    for items in Iterators.product(matrix, matrix, matrix)
        a, b, c = items
        if a + b + c == 2020
            return a * b * c
        end
    end
end

demo = Int[1721 979 366 299 675 1456]
println(product_of_year_sum(demo))
# 514579
println(product_product_of_year_sum(demo))
# 241861950


input = readdlm("input", Int)[:,1] # throw second dim
println(product_of_year_sum(input))
# 1013211
println(product_product_of_year_sum(input))
# 13891280

benchmark = readdlm("benchmark", Int)[:,1] 
@btime product_of_year_sum(benchmark)
@btime product_product_of_year_sum(benchmark)