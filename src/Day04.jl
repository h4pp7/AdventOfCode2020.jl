module Day04
using AdventOfCode2020

# Passports are separated by blank lines. But fields are not in the same order
const passports = readinput(joinpath(@__DIR__, "Day04_input.txt")) |>
                  x -> split(x, "\n\n")

#= required fields
byr (Birth Year), iyr (Issue Year), eyr (Expiration Year), hgt (Height), 
hcl (Hair Color), ecl (Eye Color), pid (Passport ID)

cid (Country ID) # optional
=#

# Wenn ich die so gruppiere teste ich ja nur, ob sie eines von den feldern
# haben. Nur nach den substrings will ich nicht suchen, weil was wenn die in den
# values mal vorkommen

const requiered_fields = [r"(^|\s)(b|i|e)yr:\S", r"(^|\s)(h|e)cl:\S",
		  				  r"(^|\s)hgt:\S", r"(^|\s)pid:\S"]

function solve(passports = passports, required_fields = requiered_fields)
    (Part1=part1(passports, requiered_fields), Part2=part2(data))
end

function part1(passports = passports, required_fields = requiered_fields)
	checks = [
		occursin(r, p) for p in passports, r in requiered_fields
	]

	sum(mapslices(all, checks, dims = [2]))

#= msum = zeros(eltype(m), size(m, 1))
for j = 1:size(m,2)
    for i = 1:size(m,1)
        msum[i] += m[i,j]
    end
end
=#
end

function part2(data)
    missing
end
end # module
