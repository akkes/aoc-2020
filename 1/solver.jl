using DelimitedFiles
using Printf


function product_of_year_sum(matrix)
    which_mask = [2020 == (a + b) for a in matrix, b in matrix]
    pos = findfirst(which_mask)
    return matrix[pos[1]] * matrix[pos[2]]
end

matrix = [1721; 979; 366; 299; 675; 1456]
@printf("%d\n", product_of_year_sum(matrix))
# 514579

matrix = readdlm("input")[:,1] # throw second dim
@printf("%d\n", product_of_year_sum(matrix))
# 1013211