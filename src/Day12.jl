module Day12
using AdventOfCode2020

const input = readinput(joinpath(@__DIR__, "Day12_input.txt"))

const D = Dict("N" => 0+1im, 
               "E" => 1+0im, 
               "S" => 0-1im, 
               "W" => -1+0im,
               "R" => 0-1im,
               "L" => 0+1im)

function parse_str(string = input)
    dirs = [] 
    for m in eachmatch(r"([A-Z]+)(\d+)", string)
        push!(dirs, (m.captures[1], parse(Int, m.captures[2])))
    end
    dirs
end

function solve(data = input)
    dirs = parse_str(data)
    solution1 = part1(dirs)
    solution2 = part2(dirs)
    (Part1=solution1, Part2=solution2)
end

function part1(dirs)
    pos = 0+0im
    dir = 1+0im
    
    for (d, n) in dirs
        if occursin(d, "RL")
            dir *= D[d] ^ (n ÷ 90)
        elseif occursin(d, "NESW")
            pos += D[d] * n
        else
            pos += dir * n
        end
    end
    abs(real(pos)) + abs(imag(pos))
end

function part2(dirs)
    waypoint = 10+1im
    ship = 0+0im
    
    for (d, n) in dirs
        if occursin(d, "RL")
            waypoint *= D[d] ^ (n ÷ 90)
        elseif occursin(d, "NESW")
            waypoint += D[d] * n
        else
            ship += waypoint * n
        end
    end
    abs(real(ship)) + abs(imag(ship))
end

end # module
