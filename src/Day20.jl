module Day20
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day20_input.txt"))
const monster_str = readinput(joinpath(@__DIR__, "Day20_monster_template.txt"))

function solve(data = raw_input)
    (Part1=part1(data), Part2=part2(data))
end

function parse_tiles(string)
    tiles = Dict{Int}{Array{Char,2}}()
    strings = split.(split(string, "\n\n"), ":")
    for s in strings
        k = parse(Int, split(s[1])[2])
        tiles[k] = reduce(vcat, permutedims.(collect.(splitlines(s[2]))))
    end
    return tiles
end

function find_arrangement(tiles)
    # we know: arrangement will be square    
    arr = zeros(Int, sqrt(length(tiles)))
    missing
end

function search_monster(image::AbstractMatrix, monster::AbstractMatrix)

    # TODO search for orientation -- we might have to rotate or flip the map
    # before we can find monsters
    img_hgt, img_len = size(image)[1], size(image)[2]
    mons_hgt, mons_len = size(monster)[1], size(monster)[2]
    Δi, Δj = (0:mons_hgt - 1), (0:mons_len - 1)
    monster_found = 0

    for i in 1:img_hgt - mons_hgt + 1, j in 1:img_len - mons_len + 1
        found = true  
        for k in Δi, l in Δj
            if image[i+k, j+l] != '#' && monster[k+1,l+1] == '#'
                found = false
            end
        end
        monster_found += found
	end
    return monster_found
end

function get_borders(input = raw_input)
    # collects the borders and their reversed counterparts 
    tiles_str = split.(split(input, "\n\n", keepempty = false), ":")
    borders =[]
    for (i, tile) in enumerate(tiles_str)
        push!(borders, [parse(Int, tile[1][6:end]), []])
        t = collect.(split(tile[2]))
        borders[i][2] = [
                        t[1], t[end], 
                        [t[j][1] for j in 1:length(t)], 
                        [t[j][end] for j in 1:length(t)]
                      ]  
        append!(borders[i][2], reverse.(borders[i][2]))
    end
    return borders
end

function part1(input = raw_input)
    borders = get_borders(input)
    border_counts = []
    for tile in borders
        push!(border_counts, sum(sum(tile[2] .∈ Ref(borders[i][2]) for i in 1:length(borders))))
    end
    corners = findall(x -> x == 12, border_counts)
    return reduce(*, (borders[c][1] for c in corners))
end

function part2(data)
    missing
end
end # module
