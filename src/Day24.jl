module Day24
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day24_input.txt"))

struct Hexgrid
    data::Dict{NTuple{3,Int}, Bool}
end

Hexgrid() = Hexgrid(Dict{NTuple{3,Int}, Bool}())

# Convenience methods, so that I can index into a Hexgrid like so: grid[1,1,1].
Base.getindex(H::Hexgrid, I::Int...) = getindex(H, Tuple(I))
Base.getindex(H::Hexgrid, I::Tuple) = getindex(H, NTuple{3,Int}(I))

# tiles are white by default: 
Base.getindex(H::Hexgrid, I::NTuple{3,Int}) = get(H.data, I, false)
# (basically the only reason to use a custom struct instead of the dictionary
# directly). Means I don't have to worry about out of bounds indexing or
# extending the grid at the edges (I should've done this for Day 17 as well). 

Base.setindex!(H::Hexgrid, v, I::Int...) = setindex!(H, v, Tuple(I))
Base.setindex!(H::Hexgrid, v, I::Tuple) = setindex!(H, v, NTuple{3,Int}(I))
Base.setindex!(H::Hexgrid, v, I::NTuple{3,Int}) = setindex!(H.data, v, I)

Base.copy(H::Hexgrid) = Hexgrid(copy(H.data))

const dirs = Dict(
        "e"  => (+1, -1, 0), 
        "se" => (0, -1, +1),
        "sw" => (-1, 0, +1), 
        "w"  => (-1, +1, 0),
        "nw" => (0, +1, -1), 
        "ne" => (+1, 0, -1)
      )

function parse_input(input)
    lines = splitlines(input)
    directions_regex = r"e|se|sw|w|nw|ne"
    tiles = Vector{NTuple{3,Int}}()
    for l in lines
        matches = (m.match for m in eachmatch(directions_regex, l))
        directions = map(x -> dirs[x], matches)
        push!(tiles, broadcast(+, directions...))
    end
    return tiles
end

function set_up_lobby(tiles)
    grid = Hexgrid() 
    for t in tiles
        grid[t] = ~grid[t]
    end
    return grid
end

function neighbours(tile)
    K = Vector{NTuple{3,Int}}()
    for d in values(dirs)
        push!(K, tile .+ d)
    end
    return K
end

function step(grid)
    out = copy(grid)
    tiles_to_check = Set{NTuple{3,Int}}()
    for (coordinates, color) in grid.data
        if color == true
            push!(tiles_to_check, coordinates)
            push!(tiles_to_check, neighbours(coordinates)...)
        end
    end
    for t_ind in tiles_to_check
        count = 0
        for n_ind in neighbours(t_ind)
            if grid[n_ind] == true
                count += 1
            end
        end
        if grid[t_ind] == true && count ∉ 1:2
            out[t_ind] = false
        elseif grid[t_ind] == false && count == 2
            out[t_ind] = true
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
    # TODO filter out even numbered tiles?
    return count(values(grid.data))
end

function part2(grid, steps)
    for i in 1:steps
        grid = step(grid)
    end
    return count(values(grid.data))
end
end # module
