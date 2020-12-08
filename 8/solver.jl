using BenchmarkTools
using Profile
using InteractiveUtils

function day8a(input::Array{String})::Int
    pos = 1::Int
    executed_arr = falses(size(input))
    accumulator = 0
    while !executed_arr[pos]
        line = split(input[pos], ' ')
        op_code = line[1]
        number = parse(Int, line[2])
        # println("($pos, $accumulator) ", op_code, " ", number)
        executed_arr[pos] = true
        if op_code == "acc"
            accumulator += number
            pos += 1
        elseif op_code == "jmp"
            pos += number
        elseif op_code == "nop"
            pos += 1
        end
    end
    return accumulator
end

function day8b(input::Array{String})::Int
    # println(input)
    for changed_index in eachindex(input)
        # println(input[changed_index])
        # do the change
        if input[changed_index][1:3] == "acc"
            continue
        elseif input[changed_index][1:3] == "jmp"
            input[changed_index] = replace(input[changed_index], "jmp" => "nop")
        elseif input[changed_index][1:3] == "nop"
            input[changed_index] = replace(input[changed_index], "nop" => "jmp")
        end
        # println(input)
        # run the code
        pos = 1::Int
        executed_arr = falses(size(input))
        accumulator = 0
        while pos <= length(input) && !executed_arr[pos]
            line = split(input[pos], ' ')
            op_code = line[1]
            number = parse(Int, line[2])
            executed_arr[pos] = true
            if op_code == "acc"
                accumulator += number
                pos += 1
            elseif op_code == "jmp"
                pos += number
            elseif op_code == "nop"
                pos += 1
            end
        end
        if pos > length(input)
            return accumulator
        end
        # change back
        if input[changed_index][1:3] == "jmp"
            input[changed_index] = replace(input[changed_index], "jmp" => "nop")
        elseif input[changed_index][1:3] == "nop"
            input[changed_index] = replace(input[changed_index], "nop" => "jmp")
        end
    end
end

function main()
    demo = readlines("demo")
    
    println(day8a(demo))
    # 5
    println(day8b(demo))
    # 8

    input = readlines("input") # throw second dim

    println(day8a(input))
    # 1671
    println(day8b(input))
    # 892

    benchmark = readlines("benchmark")

    @btime day8a($benchmark)
    @btime day8b($benchmark)
end

main()