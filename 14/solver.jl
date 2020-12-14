using BenchmarkTools
using InteractiveUtils

function day14a(input::Array{String})::Int
    mask = BitArray(undef, 64)
    mask_mask = BitArray(undef, 64)
    memory_dict = Dict{UInt,UInt}()
    value = BitArray(undef, 64)
    for line in input
        if startswith(line, "mask")
            bitmask = split(line, " ")[3]
            fill!(mask, 0)
            fill!(mask_mask, 1)
            # mask = BitArray(36)
            # mask_mask = BitArray(36)
            for i_bit in eachindex(bitmask)
                bit = bitmask[i_bit]
                if bit == '1'
                    mask_mask[37 - i_bit] = 0
                    mask[37 - i_bit] = 1
                elseif bit == '0'
                    mask_mask[37 - i_bit] = 0
                    mask[37 - i_bit] = 0
                end
            end
            # println("$mask $mask_mask")
        else
            m = match(r"^mem\[(\d+)\] = (\d+)", line)
            # println(m.captures[1], " ", m.captures[2])
            digits!(value, parse(UInt, m.captures[2]), base=2)
            # println(value)
            value = (value .& mask_mask) .| mask
            # println(value)
            memory_dict[parse(UInt, m.captures[1])] = value.chunks[1]
        end
    end
    return sum(values(memory_dict))
end

function day14b(input::Array{String})::Int64
    mask = BitArray(undef, 64)
    floating_mask = BitArray(undef, 64)
    floating_bits = BitArray(undef, 64)
    memory_dict = Dict{UInt,UInt}()
    address = BitArray(undef, 64)
    for line in input
        if startswith(line, "mask")
            bitmask = split(line, " ")[3]
            fill!(mask, 0)
            fill!(floating_mask, 0)
            # mask = BitArray(36)
            # mask_mask = BitArray(36)
            for i_bit in eachindex(bitmask)
                bit = bitmask[i_bit]
                if bit == '1'
                    mask[37 - i_bit] = 1
                elseif bit == '0'
                    mask[37 - i_bit] = 0
                elseif bit == 'X'
                    floating_mask[37 - i_bit] = 1
                end
            end
            # println("$mask $floating_mask")
        else
            m = match(r"^mem\[(\d+)\] = (\d+)", line)
            # println(m.captures[1], " ", m.captures[2])
            digits!(address, parse(UInt, m.captures[1]), base=2)
            # println(address)
            address = (address .| mask)
            # println(address)
            # println(eachindex(floating_mask)[floating_mask])
            for floating in 1:2^count(floating_mask)
                digits!(floating_bits, floating, base=2)
                for (i, i_floating) in zip(1:count(floating_mask), eachindex(floating_mask)[floating_mask])
                    # println("$i $i_floating")
                    address[i_floating] = floating_bits[i]
                end
                # println(address)
                memory_dict[address.chunks[1]] = parse(UInt, m.captures[2])
            end
        end
    end
    return sum(values(memory_dict))
end

function main()
    demo = readlines("demo")
    result = day14a(demo)
    println(result)
    @assert (result == 165)
    
    demo2 = readlines("demo2")
    result = day14b(demo2)
    println(result)
    @assert (result == 208)
    
    input = readlines("input")

    result = day14a(input)
    println(result)
    @assert (result == 11612740949946)
    
    result = day14b(input)
    println(result)
    @assert (result == 3394509207186)
    
    benchmark = readlines("benchmark")

    result = day14a(benchmark)
    println(result)
    @assert (result == 12408060320841)
    
    result = day14b(benchmark)
    println(result)
    @assert (result == 4466434626828)
    

    @btime day14a($benchmark)
    @btime day14b($benchmark)
end

main()