module Day07
using AdventOfCode2020
using SparseArrays

const raw_data = readinput(joinpath(@__DIR__, "Day07_input.txt"))
const wanted_bag = "shiny gold"
const container_p = r"^\w*\s\w*(?=\sbag)"
const contained_p = r"(\d)\s(\D*\s\D*(?=\sbag))"

function make_node_dict(lines)
    nodes = Dict{String, Int}() 
    for (i, l) in enumerate(lines)
        node = match(container_p, l).match
        nodes[node] = i
    end
    nodes
end

function make_bag_matrix(lines, node_dict)
    # TODO add check if color exists as node and add as a node
    B = spzeros(Int, length(node_dict), length(node_dict))
    for (i, l) in enumerate(lines)
        for b in eachmatch(contained_p, l)
            num = parse(Int, b.captures[1])
            color = b.captures[2]
            B[i, node_dict[color]] = num
        end
    end
    B
end

function count_containers(B, d, bag)
    nz = B[:, d[bag]].nzind
    i = 1
    while i <= length(nz)
        for j ∈ B[:, nz[i]].nzind
            if j ∉ nz
                push!(nz, j)
            end
        end
        i += 1
    end
    length(nz)
end

function count_bags(B, row)
    if length(B[row,:].nzind) == 0
        return 0
    end
    s = sum(B[row,:])
    for j in B[row,:].nzind
        s += B[row, j] * count_bags(B, j)   
    end
    s
end

function solve(data = raw_data)
    lines = splitlines(data)
    bag = wanted_bag
    node_dict = make_node_dict(lines)
    B = make_bag_matrix(lines, node_dict)
    solution1 = count_containers(B, node_dict, bag)
    row = node_dict[bag]
    solution2 = count_bags(B, row)
    (Part1=solution1, Part2=solution2)
end
end # module
