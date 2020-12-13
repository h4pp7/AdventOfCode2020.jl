module Day13
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day13_input.txt"))

function parse_data(data = raw_data)
    dep, lines = split(data) 
    dep = parse(Int, dep)
    lines = replace(lines, "x" => "0") |> x -> split(x, ",") |> 
            x -> parse.(Int, x)
    return dep, lines
end

function solve(data = raw_data)
    dep, lines = parse_data(data)
    return (Part1=part1(dep, lines), Part2=part2(lines))
end

function part1(dep, lines)
    search = true
    id = 0
    t = dep - 1
    while search
        t += 1
        for l in lines 
            l == 0 && continue
            n = t % l
            if n == 0
                id = l
                search = false
                break
            end
        end
    end
    return (t - dep) * id  
end

function part2(lines)
    # TODO: implement using Chinese Remainder Theorem
    t = 0
    step = lines[1]
    for (i, l) in enumerate(lines)
        i == 1 && continue
        l == 0 && continue
        while (t + i - 1) % lines[i] != 0
            t += step 
        end
        step *= lines[i]
    end
    return t
end
end # module
