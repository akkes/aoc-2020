using BenchmarkTools
using Traceur

function find_seatid(place::String)::Float16
    row_min, row_inter = 0., 128.
    for move in place[1:7]
        row_inter /= 2
        if move === 'B'
            row_min += row_inter
        end
    end
    col_min, col_inter = 0., 8.
    for move in place[8:10]
        col_inter /= 2
        if move === 'R'
            col_min += col_inter
        end
    end
    return row_min * 8 + col_min
end

function day5(input::Array{String})::Float16
    maximum(find_seatid.(input))
end

function find_my_seat(seats_taken::Array{Bool})::Int
    for i::Int in 2:length(seats_taken) - 1
        if seats_taken[i - 1] && (!seats_taken[i]) && seats_taken[i + 1]
            return i
        end
    end
    return -1
end

function day5_partb(input::Array{String})
    seats_taken = zeros(Bool, 127 * 8 + 7)
    seat_id = find_seatid.(input)
    seats_taken[trunc.(Int, seat_id)] .= true
    find_my_seat(seats_taken)
end

const demo = readlines("demo")

println(day5(demo))
# 2
println(day5_partb(demo))
# 

const input = readlines("input") # throw second dim

println(day5(input))
# 182
println(day5_partb(input))
# 109

const benchmark = readlines("benchmark")
# @trace day5(benchmark)
# @trace day5_partb(benchmark)

@btime day5(benchmark)
@btime day5_partb(benchmark)