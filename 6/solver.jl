using BenchmarkTools
using Profile
using InteractiveUtils

function group_answera(group_str::AbstractString)::Int
    answers = zeros(Bool, 26)
    for person_str in split(group_str, '\n')
        for answer in person_str
            answers[convert(Int, answer) - 97 + 1] = true
        end
    end
    return sum(answers)
end

function day6(input::String, group_fct::Function)::Int
    sum(group_fct.(split(input, "\n\n")))
end

function group_answerb(group_str::AbstractString)::Int
    answers = ones(Bool, 26)
    partials = zeros(Bool, 26)
    for person_str in split(group_str, '\n')
        partials .= false
        for answer in person_str
            partials[convert(Int, answer) - 97 + 1] = true
        end
        answers = answers .& partials 
    end
    return sum(answers)
end

const demo = read("demo", String)

println(day6(demo, group_answera))
# 11
println(day6(demo, group_answerb))
# 6

const input = read("input", String) # throw second dim

println(day6(input, group_answera))
# 6437
println(day6(input, group_answerb))
# 3229

const benchmark = read("benchmark", String)

@btime day6(benchmark, group_answera)
@btime day6(benchmark, group_answerb)