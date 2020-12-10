using BenchmarkTools
using Profile
using InteractiveUtils

function find_sums(input::Array{Int}, memory::Int)::Int
    for i in memory + 1:length(input)
        previouses = input[i - memory:i - 1]
        current = input[i]
        # println(current, " ", previouses)
        has_sum = false
        # Julia compiler is not efficient enough
        # @simd seems to not work (it *is* experimental after all)
        # adding breaks makes it faster
        for previous_a in previouses
            for previous_b in previouses
                has_sum |= (previous_a + previous_b == current)
                if has_sum
                    break
                end
            end
            if has_sum
                break
            end
        end
        if !has_sum
            return current
        end
    end
end

function day9a(input::Array{Int}, memory::Int)::Int
    find_sums(input, memory)
end

function day9a(input::Array{String}, memory::Int)::Int
    find_sums(parse.(Int, input), memory)
end

function sum_series(input::Array{Int}, bogus_num::Int)
    # This allocates a GiB of memory
    # I have no idea why
    for i_start in 1:length(input)
        for i_stop in i_start + 1:length(input)
            tmp = input[i_start:i_stop]
            if sum(tmp) == bogus_num
                return minimum(tmp) + maximum(tmp)
            end
        end
    end
end

function day9b(input::Array{Int}, memory::Int)::Int
    bogus_num = find_sums(input, memory)
    sum_series(input, bogus_num)
end

function day9b(input::Array{String}, memory::Int)::Int
    day9b(parse.(Int, input), memory)
end

function main()
    demo = parse.(Int, readlines("demo"))
    
    result = day9a(demo, 5)
    println(result)
    @assert (result == 127)

    result = day9b(demo, 5)
    println(result)
    @assert (result == 62)

    input = parse.(Int, readlines("input"))

    result = day9a(input, 25)
    println(result)
    @assert (result == 88311122)

    result = day9b(input, 25)
    println(result)
    @assert (result == 13549369)

    benchmark = parse.(Int, readlines("benchmark"))

    @btime day9a($benchmark, 25)
    @btime day9b($benchmark, 25)
end

main()