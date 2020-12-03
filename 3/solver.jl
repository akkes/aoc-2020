using DelimitedFiles
using BenchmarkTools

function count_impacts(carte::Array{String}, y_step::Int, x_step::Int)
    count = 0
    height = length(carte)
    width = length(carte[1])
    # carte = rand(Bool, size(carte))
    # println(carte)
    for i in 0:convert(Int, floor(height / y_step) - 1)
    # for y in 1:y_step:height
        y = i * y_step + 1
        x = (i * x_step) % width + 1
        # println(carte[y][x])
        count += carte[y][x] == '#'
        # carte[y][x] = 'O'
    end
    return count
end

function count_impacts(carte::Array{String})
    count_impacts(carte, 1, 3)
end

function partb(carte::Array{String})
    prod = 1
    slopes = [1 1; 1 3; 1 5; 1 7; 2 1]
    for slope in eachrow(slopes)
        y_step, x_step = slope
        result = count_impacts(carte, y_step, x_step)
        println(result)
        prod *= result
    end
    return prod
end

demo = readlines("demo")

println(count_impacts(demo))
# 7
println(partb(demo))
# 


input = readlines("input") # throw second dim

println(count_impacts(input))
# 
println(partb(input))
# 

"""benchmark = readlines("benchmark")
@btime count_impacts(file_to_bool_array(benchmark))
@btime count_impacts(file_to_bool_array(benchmark))"""