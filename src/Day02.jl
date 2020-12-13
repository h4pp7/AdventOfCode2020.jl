module Day02
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day02_input.txt"))

function parse_pw(line)
    rule, pw = split(line, ": ")
    char = last(rule)
    min, max = rule[1:end-2] |> x -> split(x, "-") |> x -> parse.(Int, x)
    return [pw, char, min, max]
end

function solve(input = raw_data)
    rule_pw_sets = map(splitlines(input)) do l
    parse_pw(l)
    end
    return (Part1=part1(rule_pw_sets), Part2=part2(rule_pw_sets))
end

function part1(rule_pw_sets)
    valids = filter(rule_pw_sets) do line
        pw, char, min, max = line
        min <= count(isequal(char), pw) <= max
    end
    return length(valids)
end

function part2(rule_pw_sets)
    valids = filter(rule_pw_sets) do line
        pw, char, first, second = line
        xor(isequal(char, pw[first]), isequal(char, pw[second]))
    end
    return length(valids)
end
end # module
