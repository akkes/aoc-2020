using BenchmarkTools
using Profile
using InteractiveUtils

function pprint(input::BitArray)
    for row in eachrow(input)
        println(row)
    end
    print("\n")
end

function day11a(input::String)::Int
    # println(input)
    width = match(r"\n", input).offset - 1
    height = length(collect(eachmatch(r"\n", input))) + 1
    # println(width, " ", height)
    seats_mask = falses((height + 2, width + 2))
    for i in eachindex(input)
        x_input = ((i - 1) % (width + 1)) + 1::Int
        y_input = div(i - 1, (width + 1)) + 1::Int
        # println(x_input, " ", y_input)
        if input[i] == 'L'
            seats_mask[y_input + 1, x_input + 1] = true
        end
    end
    # pprint(seats_mask)
    new_taken = falses((height + 2, width + 2))
    old_taken = .!new_taken
    # pprint(new_taken)
    while old_taken != new_taken
        old_taken = copy(new_taken)
        for y in 2:height + 1
            for x in 2:width + 1
                # println(y, " ", x)
                # println(old_taken[y - 1:y + 1, x - 1:x + 1])
                value = sum(old_taken[y - 1:y + 1, x - 1:x + 1]) - old_taken[y,x]
                if value == 0
                    new_taken[y,x] = true
                elseif value >= 4
                    new_taken[y,x] = false
                end
            end
        end
        # pprint(new_taken)
        new_taken .= new_taken .& seats_mask
        # pprint(new_taken)
    end
    return sum(new_taken)
end

function day11b(input::String)::Int
    return -1
end

function main()
    demo = read("demo", String)
    
    result = day11a(demo)
    println(result)
    @assert (result == 37)

    result = day11b(demo)
    println(result)
    @assert (result == -1)

    input = read("input", String)

    result = day11a(input)
    println(result)
    @assert (result == 2210)

    result = day11b(input)
    println(result)
    @assert (result == 7086739046912)

    benchmark = read("benchmark", String)

    @btime day11a($benchmark)
    @btime day11b($benchmark)
end

main()