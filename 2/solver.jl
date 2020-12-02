using DelimitedFiles
using BenchmarkTools

struct Entry
    low::Int
    high::Int
    letter::Char
    pass::String
    function Entry(low::AbstractString, high::AbstractString, letter::AbstractString, pass::AbstractString)
        low = parse(Int, low)
        high = parse(Int, high)
        letter = letter[1]
        new(low, high, letter, pass)
    end
    function Entry(line::AbstractString)
        low, high, letter, pass = split(line, r"-| |: ")
        Entry(low, high, letter, pass)
    end
end

function parse_db(raw_db::Array{String})::Array{Entry}
    db = Array{Entry}[]
    for line in raw_db
        entry = Entry(line)
        db = [db; entry]
    end
    return db
end

function validate_entry_a(entry::Entry)::Bool
    letter_number = count(x -> (x == entry.letter), entry.pass)
    entry.low <= letter_number && letter_number <= entry.high
end

function validate_entry_b(entry::Entry)::Bool
    (entry.pass[entry.low] == entry.letter) ⊻ (entry.pass[entry.high] == entry.letter)
end

function validate_db_a(raw_db::Array{String})
    valid = 0
    db = parse_db(raw_db)
    for entry in db
        valid += validate_entry_a(entry)
    end
    return valid
end

function validate_db_b(raw_db::Array{String})
    valid = 0
    db = parse_db(raw_db)
    for entry in db
        valid += validate_entry_b(entry)
    end
    return valid
end

demo = readlines("demo")
println(validate_db_a(demo))
println(validate_db_b(demo))
# 2

input = readlines("input")
println(validate_db_a(input))
println(validate_db_b(input))

@btime validate_db_a(demo)
@btime validate_db_b(demo)
@btime validate_db_a(input)
@btime validate_db_b(input)