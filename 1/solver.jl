using DelimitedFiles
using Printf

function product_of_year_sum(matrix)
    which_mask = [2020 == (a + b) for a in matrix, b in matrix]
    results = [a * b for a in matrix, b in matrix] .* which_mask
    return sum(results) / 2 # answer was selected two times
end

matrix = [1721; 979; 366; 299; 675; 1456]
@printf("%d\n", product_of_year_sum(matrix))

matrix = readdlm("input")
@printf("%d\n", product_of_year_sum(matrix))
