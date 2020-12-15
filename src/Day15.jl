module Day15
using AdventOfCode2020

const raw_input = "2,15,0,9,1,20"

function solve(input = raw_input)
    (Part1=play(input, 2020), Part2=play(input, 30000000))
end

function play(input, N)
    list = parse.(Int, split(input, ","))
    d = Dict(list[i] => i for i in 1:length(list) - 1)
    last_n = last(list)

    for i in length(d)+2:N
        if last_n in keys(d) 
            current = i - 1 - d[last_n]
        else
            current = 0
        end
        d[last_n] = i - 1
        last_n = current
    end
    return last_n
end
end # module
