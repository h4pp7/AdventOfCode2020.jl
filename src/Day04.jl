module Day04
using AdventOfCode2020

const requiered_fields = [r"(^|\s)byr:\S", r"(^|\s)eyr:\S", r"(^|\s)iyr:\S",
                          r"(^|\s)ecl:\S", r"(^|\s)hcl:\S", r"(^|\s)hgt:\S",
                          r"(^|\s)pid:\S"]

const valid_fields = [r"byr:(19[2-9][0-9]|200[0-2])(\s|$)",
                      r"iyr:20(1[0-9]|20)(\s|$)", r"eyr:20(2[0-9]|30)(\s|$)",
                      r"hgt:(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)(\s|$)",
                      r"hcl:#([0-9]|[a-f]){6}(\s|$)",
                      r"ecl:(amb|blu|brn|gry|grn|hzl|oth)(\s|$)",
                      r"pid:[0-9]{9}(\s|$)"]

const raw_data = readinput(joinpath(@__DIR__, "Day04_input.txt"))

function solve(input = raw_data, required_fields = requiered_fields,
               valid_fields = valid_fields)
    passports = split(input, "\n\n")
    solution1 = 0
    solution2 = 0
    for p in passports  
        if all((occursin(r, p) for r in requiered_fields)) == 1
            solution1 += 1
            if all((occursin(v, p) for v in valid_fields)) == 1
                solution2 +=1
            end
        end
    end
    (Part1=solution1, Part2=solution2)
end
end # module
