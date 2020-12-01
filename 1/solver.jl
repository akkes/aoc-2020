using DelimitedFiles
using Printf


function product_of_year_sum(matrix)
    for items in Iterators.product(matrix, matrix)
        a, b = items
        if a + b == 2020
            return a * b
        end
    end
    # iter = Iterators.product(matrix, matrix)
    # pos = findfirst(x -> (2020 == sum(x)), collect(iter))
    # return matrix[pos[1]] * matrix[pos[2]]
end

function product_product_of_year_sum(matrix)
    for items in Iterators.product(matrix, matrix, matrix)
        a, b, c = items
        if a + b + c == 2020
            return a * b * c
        end
    end
end

matrix = Int[1721; 979; 366; 299; 675; 1456]
println(product_of_year_sum(matrix))
# 514579
println(product_product_of_year_sum(matrix))

matrix = readdlm("input", Int)[:,1] # throw second dim
println(product_of_year_sum(matrix))
# 1013211
println(product_product_of_year_sum(matrix))