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

function validate_entry(entry::Entry)::Bool
    letter_number = count(x -> (x == entry.letter), entry.pass)
    entry.low <= letter_number && letter_number <= entry.high
end

function validate_db(raw_db::Array{String})
    valid = 0
    db = parse_db(raw_db)
    for entry in db
        valid += validate_entry(entry)
    end
    return valid
end

demo = readlines("demo")
println(validate_db(demo))
# 2

input = readlines("input")
println(validate_db(input))
