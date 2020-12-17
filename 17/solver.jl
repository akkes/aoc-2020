using BenchmarkTools
using InteractiveUtils

"""
    I know i can do this usign a single function.
    However i don’t have the time to understand how to explain it to julia.
    Therefore this is quick & dirty
"""

function new_value3(space::BitArray{3}, indicies::Tuple)::Bool
    count = -space[indicies...]
    for x in indicies[1] - 1:indicies[1] + 1
        for y in indicies[2] - 1:indicies[2] + 1
            for z in indicies[3] - 1:indicies[3] + 1
                count += space[x,y,z]
            end
        end
    end
    if count == 3 || (count == 2 && space[indicies...])
        return true
    end
    return false
end

function day17a(input::Array{String}, dims::Int, iter::Int)::Int
    start_height = length(input)
    start_width = length(input[1])
    total_dims = fill(2 * iter + 2 + 1, dims)
    total_dims[1] = start_width + (2 * iter) + 2
    total_dims[2] = start_height + (2 * iter) + 2
    # println(total_dims)
    space = falses(total_dims...)
    # insert in array
    for (y, line) in enumerate(input)
        # line = split(input[y], "")
        for (x, char) in enumerate(line)
            space[x + iter + 1,y + iter + 1,iter + 2] = char == '#'
        end
    end
    # println(space)
    # run a step
    old = copy(space)
    for t in 1:iter
        copy!(old, space)
        for x in 2:total_dims[1] - 1
            for y in 2:total_dims[2] - 1
                for z in 2:total_dims[3] - 1
                    space[x,y,z] = new_value3(old, (x, y, z))
                end
            end
        end
        """println("---")
        println(old)
        println("===")
        println(space)"""
    end
    return count(space)
end

function day17a(input::Array{String})
    day17a(input, 3, 6)
end

function new_value4(space::BitArray{4}, indicies::Tuple)::Bool
    count = -space[indicies...]
    for x in indicies[1] - 1:indicies[1] + 1
        for y in indicies[2] - 1:indicies[2] + 1
            for z in indicies[3] - 1:indicies[3] + 1
                for w in indicies[4] - 1:indicies[4] + 1
                    count += space[x,y,z,w]
                end
            end
        end
    end
    if count == 3 || (count == 2 && space[indicies...])
        return true
    end
    return false
end

function day17b(input::Array{String}, dims::Int, iter::Int)::Int
    start_height = length(input)
    start_width = length(input[1])
    total_dims = fill(2 * iter + 2 + 1, dims)
    total_dims[1] = start_width + (2 * iter) + 2
    total_dims[2] = start_height + (2 * iter) + 2
    # println(total_dims)
    space = falses(total_dims...)
    # insert in array
    for (y, line) in enumerate(input)
        # line = split(input[y], "")
        for (x, char) in enumerate(line)
            space[x + iter + 1,y + iter + 1,iter + 2, iter + 2] = char == '#'
        end
    end
    # println(space)
    # run a step
    old = copy(space)
    for t in 1:iter
        copy!(old, space)
        for x in 2:total_dims[1] - 1
            for y in 2:total_dims[2] - 1
                for z in 2:total_dims[3] - 1
                    for w in 2:total_dims[4] - 1
                        space[x,y,z,w] = new_value4(old, (x, y, z, w))
                    end
                end
            end
        end
    end
    return count(space)
end

function day17b(input::Array{String})::Int
    return day17b(input, 4, 6)
end

function main()
    demo = readlines("demo")
    result = day17a(demo)
    println(result)
    @assert (result == 112)

    result = day17b(demo)
    println(result)
    @assert (result == 848)

    input = readlines("input")

    result = day17a(input)
    println(result)
    @assert (result == 295)
    
    result = day17b(input)
    println(result)
    @assert (result == 1972)
    
    benchmark = readlines("input")

    result = day17a(benchmark)
    println(result)
    # @assert (result == 20013)
    
    result = day17b(benchmark)
    println(result)
    # @assert (result == 5977293343129)
    

    @btime day17a($benchmark)
    @btime day17b($benchmark)
end

main()