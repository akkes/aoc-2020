using BenchmarkTools
using Profile
using InteractiveUtils

function day7a(input::Array{String})::Int
    # containers_str = split.(input, " bags contain ")
    # println(containers_str)
    parents_dict = Dict{AbstractString,Array{AbstractString}}()
    for rule in input
        container_str, containees_str = split(rule, " bags contain ")
        for containee_str in split(containees_str, ", ")
            # println(containee_str)
            start_m = findfirst(r"\d+ ", containee_str)
            if start_m === nothing
                continue
            end
            end_m = findfirst(r" bag(s)?", containee_str)
            # println(containee_str[start_m.stop + 1:end_m.start - 1])
            containee_type = containee_str[start_m.stop + 1:end_m.start - 1]
            if haskey(parents_dict, containee_type)
                push!(parents_dict[containee_type], container_str)
            else
                parents_dict[containee_type] = [container_str]
            end
        end
    end
    # println(parents_dict)
    new_set = Set(["shiny gold"])::Set{String}
    # push!(old_set, )
    old_set = Set{String}()
    while old_set != new_set
        # println(new_set)
        old_set = new_set
        for (child, parents) in parents_dict
            if child ∈ new_set
                for parent in parents
                    push!(new_set, parent)
                end
            end
        end
    end
    # println(new_set)
    return length(new_set) - 1
end

function reccurb(dict::Dict{String,Array{Tuple{Int,AbstractString}}}, container::AbstractString)::Int
    total = 1
    for child in dict[container]
        total += child[1] * reccurb(dict, child[2])
    end
    return total
end

function day7b(input::Array{String})::Int
    # containers_str = split.(input, " bags contain ")
    # println(containers_str)
    childs_dict = Dict{String,Array{Tuple{Int,AbstractString}}}()
    for rule in input
        container_str, containees_str = split(rule, " bags contain ")
        containees = Tuple{Int,AbstractString}[]
        for containee_str in split(containees_str, ", ")
            # println(containee_str)
            start_m = findfirst(r"\d+ ", containee_str)
            if start_m === nothing
                continue
            end
            end_m = findfirst(r" bag(s)?", containee_str)
            # println(containee_str[start_m.stop + 1:end_m.start - 1])
            containee_type = containee_str[start_m.stop + 1:end_m.start - 1]
            times = parse(Int, containee_str[begin:start_m.stop])
            item = tuple(times, containee_type)
            # println(typeof(item), " ", item)
            push!(containees, item)
        end
        childs_dict[container_str] = containees
    end
    # println(childs_dict)
    return reccurb(childs_dict, "shiny gold") - 1
end

function main()
    demo = readlines("demo")
    
    println(day7a(demo))
    # 4
    println(day7b(demo))
    # 32

    demo2 = readlines("demo2")
    
    println(day7b(demo2))
    # 126

    input = readlines("input") # throw second dim

    println(day7a(input))
    # 272
    println(day7b(input))
    # 172246

    benchmark = readlines("input")

    @btime day7a($benchmark)
    @btime day7b($benchmark)
end

main()