using BenchmarkTools
using InteractiveUtils

function day12a(input::Array{String})::Int
    start_timestamp = parse(Int, input[1])
    busses = parse.(Int, filter(x -> x != "x", split(input[2], ",")))
    previous_passage = start_timestamp .% busses
    next_passage = busses .- previous_passage
    earlyest_bus = minimum(next_passage)
    which_bus = busses[findfirst(next_passage .== earlyest_bus)]
    return which_bus * earlyest_bus
end

function is_answer(timestamp::Int64, busses::Array{Int64}, delay::Array{Int64})::Bool
    all(is_checked(timestamp, busses, delay))
end

function is_checked(timestamp::Int64, busses::Array{Int64}, delay::Array{Int64})::Array{Bool}
    ((timestamp .+ delay) .% busses) .== 0
end

function loop(timestamp::Int64, step::Int64, busses::Array{Int64}, delay::Array{Int64})
    i_bus = 1
    while !is_answer(timestamp, busses, delay)
        if all(is_checked(timestamp, busses, delay)[1:i_bus + 1])
            i_bus += 1
            step *= busses[i_bus]
        end
        timestamp += step
    end
    return timestamp
end

function day12b(input::S)::Int64 where S <: AbstractString
    items = split(input, ",")
    has_constraint = items .!= "x"
    busses = parse.(Int64, items[has_constraint])
    # @show prod(busses)
    delay = collect(eachindex(items))[has_constraint] .- 1
    # return solveb(busses, delay)
    step = busses[1]
    return loop(busses[1], step, busses, delay)
end

function day12b(input::Array{S})::Int64 where S <: AbstractString
    return day12b(input[2])
end

function main()
    demo = readlines("demo")
    
    result = day12a(demo)
    println(result)
    @assert (result == 295)
    
    result = day12b("17,x,13,19")
    println(result)
    @assert (result == 3417)
    
    result = day12b(demo)
    println(result)
    @assert (result == 1068781)
    
    result = day12b("67,7,59,61")
    println(result)
    @assert (result == 754018)
    result = day12b("67,x,7,59,61")
    println(result)
    @assert (result == 779210)
    result = day12b("67,7,x,59,61")
    println(result)
    @assert (result == 1261476)
    result = day12b("1789,37,47,1889")
    println(result)
    @assert (result == 1202161486)

    input = readlines("input")

    result = day12a(input)
    println(result)
    @assert (result == 5946)

    result = day12b(input[2])
    println(result)
    @assert (result == 645338524823718)

    benchmark = readlines("benchmark")

    result = day12a(benchmark)
    println(result)
    @assert (result == 156)

    result = day12b(benchmark)
    println(result)
    # > 10229
    @assert (result == 404517869995362)

    @btime day12a($benchmark)
    @btime day12b($benchmark)
end

main()