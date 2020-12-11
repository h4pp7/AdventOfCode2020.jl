module Day11
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day11_input.txt"))

function floorplan(input)
    lines = split(input)
    mapreduce(hcat, lines) do l
        map(collect(l)) do c
            if c == 'L' 
                c = 1
            elseif c == '#'
                c = 2
            else
                c = 0
            end
        end
    end
end

function step_part1(seats)
    # I would like to avoid copy, but for that 0 has to be written inside the
    # loop for floor tiles
    out = copy(seats)
    R = CartesianIndices(seats)
    Ifirst, Ilast = first(R), last(R)
    I1 = oneunit(Ifirst)
    for I in R
        seats[I] == 0 && continue # if I don't want to copy, I cant do this
        s = zero(eltype(out)) 
        for J in max(Ifirst, I - I1):min(Ilast, I + I1)
            seats[J] == 0 && continue
            if seats[J] == 2
                s += 1
            end
        end
        if s == 0
            out[I] = 2
        elseif s > 4
            out[I] = 1
        end
    end
    out
end

function step_part2(seats)
    out = copy(seats)
    R = CartesianIndices(seats)
    Ifirst, Ilast = first(R), last(R)
    D = [CartesianIndex(i, j) for i in (-1, 0, 1), j in (-1, 0, 1)]
    for I in R
        seats[I] == 0 && continue
        s = zero(eltype(out)) 
        for J in D
            K = I + J
            while true
                if checkbounds(Bool, seats, K) == false
                    break
                end
                if seats[K] == 2
                    s += 1
                    break
                elseif seats[K] == 1
                    break
                end
                K += J
            end
        end
        if s == 0
            out[I] = 2
        elseif s > 5
            out[I] = 1
        end
    end
    out
end

function part1(seats)
    h = hash(seats)
    old_h = 0
    while old_h != h
        old_h = h
        seats = step_part1(seats)
        h = hash(seats)
    end 
    count(x -> x == 2, seats)
end

function part2(seats)
    h = hash(seats)
    old_h = 0
    while old_h != h
        old_h = h
        seats = step_part2(seats)
        h = hash(seats)
    end 
    count(x -> x == 2, seats)
end

function solve(data = raw_data)
    seats = floorplan(data)
    solution1 = part1(seats)
    solution2 = part2(seats)
    (Part1=solution1, Part2=solution2)
end
end # module
