module Day11
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day11_input.txt"))

function step_part1(seats)
    # I would like to avoid copy, but for that 'L' has to be written inside the
    # loop for floor tiles
    out = copy(seats)
    R = CartesianIndices(seats)
    Ifirst, Ilast = first(R), last(R)
    I1 = oneunit(Ifirst)
    for I in R
        seats[I] == '.' && continue # if I don't want to copy, I cant do this
        s = 0
        for J in max(Ifirst, I - I1):min(Ilast, I + I1)
            seats[J] == '.' && continue
            if seats[J] == '#'
                s += 1
            end
        end
        if s == 0
            out[I] = '#'
        elseif s > 4
            out[I] = 'L'
        end
    end
    # copy!(out, seats) # this would save quite some mem and allocs, but
    # there's something happening with scope -- the second part doesn't give
    # the right answer anymore
    return out
end

function step_part2(seats)
    out = copy(seats)
    R = CartesianIndices(seats)
    Ifirst, Ilast = first(R), last(R)
    D = [CartesianIndex(i, j) for i in (-1, 0, 1), j in (-1, 0, 1)]
    for I in R
        seats[I] == '.' && continue
        s = 0 
        for J in D
            K = I + J
            while true
                if checkbounds(Bool, seats, K) == false
                    break
                end
                if seats[K] == '#'
                    s += 1
                    break
                elseif seats[K] == 'L'
                    break
                end
                K += J
            end
        end
        if s == 0
            out[I] = '#'
        elseif s > 5
            out[I] = 'L'
        end
    end
    return out
end

function part1(seats)
    h = hash(seats)
    old_h = 0
    while old_h != h
        old_h = h
        seats = step_part1(seats)
        h = hash(seats)
    end 
    return count(x -> x == '#', seats)
end

function part2(seats)
    h = hash(seats)
    old_h = 0
    while old_h != h
        old_h = h
        seats = step_part2(seats)
        h = hash(seats)
    end 
    return count(x -> x == '#', seats)
end

function solve(data = raw_data)
    seats = reduce(vcat, permutedims.(collect.(split(data))))
    solution1 = part1(seats)
    solution2 = part2(seats)
    return (Part1=solution1, Part2=solution2)
end
end # module
