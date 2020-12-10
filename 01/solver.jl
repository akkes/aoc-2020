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
    for a in matrix
        for b in matrix
            if a + b >= 2020
                continue
            end
            for c in matrix
                if a + b + c == 2020
                    return a * b * c
                end
            end
        end
    end
end

function main()
    demo = Int[1721 979 366 299 675 1456]
    input = readdlm("input", Int)[:,1] # throw second dim
    result = product_of_year_sum(demo)
    println(result)
    @assert (result == 514579)

    result = product_product_of_year_sum(demo)
    println(result)
    @assert (result == 241861950)


    input = readdlm("input", Int)[:,1] # throw second dim
    result = product_of_year_sum(input)
    println(result)
    @assert (result == 1013211)
    
    result = product_product_of_year_sum(input)
    println(result)
    @assert (result == 13891280)

    benchmark = readdlm("benchmark", Int)[:,1] 
    @btime product_of_year_sum($benchmark)
    @btime product_product_of_year_sum($benchmark)
end

main()