using BenchmarkTools

function is_valid_passport_a(passport::Dict)::Bool
    valid = haskey(passport, "byr") && haskey(passport, "iyr") && haskey(passport, "eyr") && haskey(passport, "hgt") && haskey(passport, "hcl") && haskey(passport, "ecl") && haskey(passport, "pid")
end

function is_valid_passport_b(passport::Dict)::Bool
    if !is_valid_passport_a(passport)
        return false
    end
    valid = 1920 <= parse(Int, passport["byr"]) <= 2002
    valid *= 2010 <= parse(Int, passport["iyr"]) <= 2020
    valid *= 2020 <= parse(Int, passport["eyr"]) <= 2030
    if endswith(passport["hgt"], "cm")
        valid *= 150 <= parse(Int, passport["hgt"][begin:end - 2]) <= 193
    elseif endswith(passport["hgt"], "in")
        valid *= 59 <= parse(Int, passport["hgt"][begin:end - 2]) <= 76
    else
        return false
    end
    # println(passport["hcl"], startswith(passport["hcl"], r"#[a-f0-9]{6}"), endswith(passport["hcl"], r"#[a-f0-9]{6}"))
    valid *= startswith(passport["hcl"], r"\A#[a-f0-9]{6}\Z")
    valid *= in(passport["ecl"], ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
    # println(passport["pid"], startswith(passport["pid"], r"\A\d{9}\Z"), endswith(passport["pid"], r"\A\d{9}\Z"))
    valid *= startswith(passport["pid"], r"\A\d{9}\Z")
    return valid
end

function day3(input::String, validation::Function)
    nb_valid = 0::Int
    passports = split(input, "\n\n")
    # println(passports)
    passports = split.(passports, r" |\n")
    # println(passports)
    count = 0::Int
    for passport in passports
        passport = split.(passport, ":")
        dict = Dict(passport)
        # println(dict)
        count += validation(dict)
    end
    return count
end

demo = read("demo", String)

println(day3(demo, is_valid_passport_a))
# 2
println(day3(demo, is_valid_passport_b))
# 

invalid = "eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007"
println(day3(invalid, is_valid_passport_b))
valid = "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
println(day3(valid, is_valid_passport_b))
# 4

benchmark = read("benchmark", String) # throw second dim

println(day3(benchmark, is_valid_passport_a))
# 216
println(day3(benchmark, is_valid_passport_b))
# 150

input = read("input", String) # throw second dim

println(day3(input, is_valid_passport_a))
# 182
println(day3(input, is_valid_passport_b))
# 109
# 

benchmark = read("benchmark", String)
@btime day3(benchmark, is_valid_passport_a)
@btime day3(benchmark, is_valid_passport_b)