using BenchmarkTools
using InteractiveUtils

function run(input::Array{Int}, stop::Int)::Int
    previouses = zeros(Int, stop)
    previous_previouses = zeros(Int, stop)
    for (i, number) in zip(1:length(input), input[begin:end])
        previouses[number + 1] = i
    end
    # println(input)
    new_num = 0
    for i in (length(input) + 1):(stop - 1)
        if previouses[new_num + 1] == 0
            # println("$i: 0:new")
            previouses[new_num + 1] = i
            new_num = 0
        else
            previous_previouses[new_num + 1] = previouses[new_num + 1]
            previouses[new_num + 1] = i
            # println("$i: $new_num:$(previouses[new_num + 1]) - $(previous_previouses[new_num + 1])")
            new_num = previouses[new_num + 1] - previous_previouses[new_num + 1]
        end
        # println("$i: $new_num")
        # println("$new_num:$(previouses[1:10])")
    end
    return new_num
end

function run(input::Array{Int})::Int
    run(input, 2020)
end

function day15a(input::String)::Int
    run(parse.(Int, split(input, ",")))
end

function day15b(input::String)::Int64
    run(parse.(Int, split(input, ",")), 30000000)
end

function main()
    demo = read("demo", String)
    result = day15a(demo)
    println(result)
    @assert (result == 436)
    
    demo2 = "1,3,2"
    result = day15a(demo2)
    println(result)
    @assert (result == 1)
    
    input = read("input", String)

    result = day15a(input)
    println(result)
    @assert (result == 441)
    
    result = day15b(input)
    println(result)
    @assert (result == 10613991)
    
    benchmark = read("benchmark", String)

    result = day15a(benchmark)
    println(result)
    @assert (result == 496)
    
    result = day15b(benchmark)
    println(result)
    @assert (result == 883)
    

    @btime day15a($benchmark)
    @btime day15b($benchmark)
end

main()