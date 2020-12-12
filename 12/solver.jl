using BenchmarkTools
using Profile
using InteractiveUtils


function pprint(input::BitArray)
    for row in eachrow(input)
        println(row)
    end
    print("\n")
end

mutable struct Point
    x::Int
    y::Int
end

function day12a(input::Array{String})::Int
    # use anticlockwise coordinates
    direction = 'E'
    pos = Point(0, 0)
    for line in input
        num = parse(Int, line[2:end])
        if line[1] == 'N'
            pos.y += num
        elseif line[1] == 'S'
            pos.y -= num
        elseif line[1] == 'E'
            pos.x += num
        elseif line[1] == 'W'
            pos.x -= num
        elseif line[1] == 'L'
            for i in 90:90:num
                if direction == 'N'
                    direction = 'W'
                elseif direction == 'W'
                    direction = 'S'
                elseif direction == 'S'
                    direction = 'E'
                elseif direction == 'E'
                    direction = 'N'
                end
            end
        elseif line[1] == 'R'
            for i in 90:90:num
                if direction == 'N'
                    direction = 'E'
                elseif direction == 'E'
                    direction = 'S'
                elseif direction == 'S'
                    direction = 'W'
                elseif direction == 'W'
                    direction = 'N'
                end
            end
        elseif line[1] == 'F'
            if direction == 'N'
                pos.y += num
            elseif direction == 'S'
                pos.y -= num
            elseif direction == 'E'
                pos.x += num
            elseif direction == 'W'
                pos.x -= num
            end
        end
    end
    return abs(pos.x) + abs(pos.y)
end

function day12b(input::Array{String})::Int
    # use anticlockwise coordinates
    ship = Point(0, 0)
    waypoint = Point(10, 1)
    for line in input
        num = parse(Int, line[2:end])
        if line[1] == 'N'
            waypoint.y += num
        elseif line[1] == 'S'
            waypoint.y -= num
        elseif line[1] == 'E'
            waypoint.x += num
        elseif line[1] == 'W'
            waypoint.x -= num
        elseif line[1] == 'L'
            for _ in 90:90:num
                waypoint.x, waypoint.y = -waypoint.y, waypoint.x
            end
        elseif line[1] == 'R'
            for _ in 90:90:num
                waypoint.x, waypoint.y = waypoint.y, -waypoint.x
            end
        elseif line[1] == 'F'
            times = num
            ship.x += times * waypoint.x
            ship.y += times * waypoint.y
        end
        # println("$ship, $waypoint")
    end
    return abs(ship.x) + abs(ship.y)
end


function main()
    demo = readlines("demo")
    
    result = day12a(demo)
    println(result)
    @assert (result == 25)

    result = day12b(demo)
    println(result)
    @assert (result == 286)

    input = readlines("input")

    result = day12a(input)
    println(result)
    @assert (result == 439)

    result = day12b(input)
    println(result)
    @assert (result == 12385)

    benchmark = readlines("benchmark")

    result = day12a(benchmark)
    println(result)
    @assert (result == 1496)

    result = day12b(benchmark)
    println(result)
    # > 10229
    @assert (result == 63843)

    @btime day12a($benchmark)
    @btime day12b($benchmark)
end

main()