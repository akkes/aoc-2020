using BenchmarkTools
using InteractiveUtils

function day16a(input::String)::Int
    rules_str, my_ticket_str, tickets_str = split(input, "\n\n")
    error_rate = 0
    for ticket in split(tickets_str, "\n")[begin + 1:end]
        for field in split(ticket, ",")
            value = parse(Int, field)
            valid = false
            for rule in split(rules_str, "\n")
                m = match(r"(\w): (\d+)-(\d+) or (\d+)-(\d+)", rule)
                intervals = parse.(Int, m.captures[begin + 1:end])
                # println(intervals)
                if ((intervals[1] <= value && value <= intervals[2]) || (intervals[3] <= value && value <= intervals[4]))
                    # println("$(intervals[1]) <= $value <= $(intervals[2]) && $(intervals[3]) <= $value <= $(intervals[4])")
                    valid = true
                end
            end
            if !valid
                error_rate += value
            end
        end
    end
    return error_rate
end

function day16b(input::String)::Int64
    rules_str, my_ticket_str, tickets_str = split(input, "\n\n")
    tickets = split(tickets_str, "\n")[begin + 1:end]
    valid_mask = falses(length(tickets))
    for (i_ticket, ticket) in enumerate(tickets)
        valid_ticket = true
        for field in split(ticket, ",")
            value = parse(Int, field)
            valid_field = false
            for rule in split(rules_str, "\n")
                m = match(r"(\w+): (\d+)-(\d+) or (\d+)-(\d+)", rule)
                intervals = parse.(Int, m.captures[begin + 1:end])
                # println(intervals)
                if ((intervals[1] <= value && value <= intervals[2]) || (intervals[3] <= value && value <= intervals[4]))
                    valid_field = true
                end
            end
            valid_ticket &= valid_field
        end
        valid_mask[i_ticket] = valid_ticket
    end
    println(valid_mask)
    # myticket parsing
    myfields = parse.(Int, split(split(my_ticket_str, "\n")[2], ","))
    total = 1
    # find matches
    valid_tickets = tickets[valid_mask]
    rules = split(rules_str, "\n")
    mask_notattributed = trues(length(rules))
    old = falses(length(rules))
    while (any(mask_notattributed) && mask_notattributed != old)
        copy!(old, mask_notattributed)
        # println(mask_notattributed)
        println(collect(rules)[mask_notattributed])
        for (i_rule, rule) in collect(enumerate(rules))[mask_notattributed]
            m = match(r"(\w+): (\d+)-(\d+) or (\d+)-(\d+)", rule)
            # println(m.captures)
            intervals = parse.(Int, m.captures[begin + 1:end])
            rules_match = trues(length(rules))
            for ticket in tickets[valid_mask]
                for (i_field, field) in enumerate(split(ticket, ","))
                    value = parse(Int, field)
                    if !((intervals[1] <= value <= intervals[2]) || (intervals[3] <= value <= intervals[4]))
                        rules_match[i_field] = false
                    end
                end
                # println(rules_match)
            end
            if count(rules_match[mask_notattributed]) == 1
                i_column = firstindex(rules_match)
                println(m.captures[1])
                if startswith(m.captures[1], "departure")
                    total *= myfields[i_column]
                end
                mask_notattributed[i_rule] = false
            elseif count(rules_match[mask_notattributed]) == 0
                println("useless")
            else
                println("not selective enough: ", count(rules_match[mask_notattributed]))
            end
        end
    end
    return total
end

function main()
    demo = read("demo", String)
    result = day16a(demo)
    println(result)
    @assert (result == 71)

    demo2 = read("demo2", String)
    result = day16b(demo2)
    println(result)
    # @assert (result == 0)

    input = read("input", String)

    result = day16a(input)
    println(result)
    @assert (result == 25984)
    
    result = day16b(input)
    println(result)
    # @assert (result == 10613991)
    
    benchmark = read("benchmark", String)

    result = day16a(benchmark)
    println(result)
    @assert (result == 20013)
    
    result = day16b(benchmark)
    println(result)
    # @assert (result == 5977293343129)
    

    @btime day16a($benchmark)
    return
    @btime day16b($benchmark)
end

main()