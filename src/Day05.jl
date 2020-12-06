module Day05
using AdventOfCode2020
using LinearAlgebra

const raw_data = readinput(joinpath(@__DIR__, "Day05_input.txt"))

@inline function converttodec(line)
        idvector = in.(collect(line), "BR")
        # dot product to multiply each number in the vevor with 0, 2, 4, 8 etc
        # to get the decimal number
        dot(idvector, 2 .^(9:-1:0))
end

function solve(input = raw_data)
    (Part1=part1(input), Part2=part2(input))
end

function part1(data = raw_data)
    maximum((converttodec(line) for line in splitlines(data)))
end

function part2(data = raw_data)
    lines = splitlines(data)  
    (minid, maxid, xorid) = 1024, 0, 0
    for line in lines
        id = converttodec(line)
        maxid = max(maxid, id)
        minid = min(minid, id)
        xorid ⊻= id # xor all ids with each other
        # since xor all ids is 0, my missing one must be what's left
    end
    for i = minid:maxid
        xorid ⊻= i
    end
    xorid
end
end # module
