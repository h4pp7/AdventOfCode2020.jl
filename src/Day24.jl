module Day24
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day24_input.txt"))

struct Hexgrid
    data::Dict{CartesianIndex, Bool}
end

Hexgrid() = Hexgrid(Dict{CartesianIndex, Bool}())
Base.getindex(H::Hexgrid, I::Int...) = getindex(H, CartesianIndex(I))
Base.getindex(H::Hexgrid, I::NTuple{N,Int}) where {N} = getindex(H, CartesianIndex(I))
Base.getindex(H::Hexgrid, I) = get(H.data, I, false) # tiles are white by default
Base.setindex!(H::Hexgrid, v, I::Int...) = setindex!(H, v, CartesianIndex(I))
Base.setindex!(H::Hexgrid, v, I) = (H.data[I] = v)
Base.copy(H::Hexgrid) = Hexgrid(copy(H.data))

const dirs = Dict(
        "e"  => CartesianIndex(+1, -1, 0), 
        "se" => CartesianIndex(0, -1, +1),
        "sw" => CartesianIndex(-1, 0, +1), 
        "w"  => CartesianIndex(-1, +1, 0),
        "nw" => CartesianIndex(0, +1, -1), 
        "ne" => CartesianIndex(+1, 0, -1)
      )

function parse_input(input)
    lines = splitlines(input)
    directions_regex = r"e|se|sw|w|nw|ne"
    return [
         mapreduce(x -> dirs[x], +, 
                   (m.match for m in eachmatch(directions_regex, l))) 
         for l in lines
        ]
end

function set_up_lobby(tiles)
    grid = Hexgrid() 
    for t in tiles
        grid[t] = ~grid[t]
    end
    return grid
end

function neighbours(tile)
    K = Vector{CartesianIndex}()
    for d in values(dirs)
        push!(K, tile + d)
    end
    return K
end

function step(grid)
    out = copy(grid)
    living = Vector{CartesianIndex}()
    for (k, v) in grid.data
        if v
            push!(living, k)
        end
    end
    checked = Vector{CartesianIndex}()
    for I in living
        c = 0
        for J in neighbours(I)
            if grid[J] == true
                c += 1
            end
            J in checked && continue
            s = 0
            for K in neighbours(J)
                if grid[K]
                    s += 1
                end
            end
            if grid[J] == true && s ∉ 1:2
                out[J] = false
            elseif grid[J] == false && s == 2
                out[J] = true
            end
        end
        if grid[I] == true && c ∉ 1:2
            out[I] = false
        elseif grid[I] == false && c == 2
            out[I] = true
        end
    end
    return out
end

function solve(input = raw_input)
    tiles = parse_input(input)
    grid = set_up_lobby(tiles)
    (Part1=part1(grid), Part2=part2(grid, 100))
end

function part1(grid)  
    # TODO filter out even numbered tiles
    return count(values(grid.data))
end

function part2(grid, steps)
    for i in 1:steps
        grid = step(grid)
    end
    return count(values(grid.data))
end
end # module
