using DelimitedFiles
using Printf


function product_of_year_sum(matrix)
    which_mask = [2020 == (a + b) for a in matrix, b in matrix]
    pos = findfirst(which_mask)
    return matrix[pos[1]] * matrix[pos[2]]
end

function product_product_of_year_sum(matrix)
    mask = [2020 == (a + b + c) for a in matrix, b in matrix, c in matrix]
    pos = findfirst(mask)
    return matrix[pos[1]] * matrix[pos[2]] * matrix[pos[3]]
end

matrix = Int[1721; 979; 366; 299; 675; 1456]
println(product_of_year_sum(matrix))
# 514579
println(product_product_of_year_sum(matrix))

matrix = readdlm("input", Int)[:,1] # throw second dim
println(product_of_year_sum(matrix))
# 1013211
println(product_product_of_year_sum(matrix))