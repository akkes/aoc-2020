using BenchmarkTools
using Profile
using InteractiveUtils

function day10a!(input::Array{Int})::Int
    pushfirst!(input, 0)
    built_in_volt = maximum(input) + 3
    append!(input, built_in_volt)
    sort!(input)
    diffs = diff(input)
    num_ones = count(diffs .== 1)
    num_three = count(diffs .== 3)
    # println(num_ones, " ", num_three)
    return num_ones * num_three
end

function day10a(input::Array{String})::Int
    day10a!(parse.(Int, input))
end

function day10a(input::Array{Int})::Int
    day10a!(copy(input))
end

function day10b!(input::Array{Int})::Int
    # println(input)
    pushfirst!(input, 0)
    built_in_volt = maximum(input) + 3
    append!(input, built_in_volt)
    sort!(input)
    # println(input)
    arrangements = zeros(size(input))
    arrangements[end] = 1
    for i in length(input) - 1:-1:1
        for j in i + 1:min(i + 3, length(input))
            if (input[j] - input[i]) <= 3
                arrangements[i] += arrangements[j]
            end
        end
    end
    # println(arrangements)
    return arrangements[1]
end

function day10b(input::Array{Int})::Int
    day10b!(copy(input))
end

function day10b(input::Array{String})::Int
    day10b!(parse.(Int, input))
end

function main()
    demo = parse.(Int, readlines("demo"))
    
    result = day10a(demo)
    println(result)
    @assert (result == 7 * 5)

    result = day10b(demo)
    println(result)
    @assert (result == 8)

    demo2 = parse.(Int, readlines("demo2"))
    
    result = day10a(demo2)
    println(result)
    @assert (result == 22 * 10)

    result = day10b(demo2)
    println(result)
    @assert (result == 19208)

    input = parse.(Int, readlines("input"))

    result = day10a(input)
    println(result)
    @assert (result == 2210)

    result = day10b(input)
    println(result)
    @assert (result == 7086739046912)

    benchmark = parse.(Int, readlines("benchmark"))

    @btime day10a($benchmark)
    @btime day10b($benchmark)
end

main()