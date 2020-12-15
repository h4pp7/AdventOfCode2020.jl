module Day14
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day14_input.txt"))

function powerset(v)
    result = [[]]
    for x in v, j in eachindex(result)
        push!(result, [result[j] ; x])
    end
    return result
end

function parse_mask(line)
    mask_str = last(line, 36)
    a = replace(mask_str, "X" => "0") |> x -> parse(Int, x, base = 2)
    b = replace(mask_str, "X" => "1") |> x -> parse(Int, x, base = 2)
    return a, b
end

function parse_addr_mask(line)
    mask_str = last(line, 36)
    a = replace(mask_str, "X" => "0") |> x -> parse(Int, x, base = 2)
    b_str = replace(mask_str, "0" => "1")
    b = replace(b_str, "X" => "0") |> x -> parse(Int, x, base = 2)
    possible_X = findall(c -> c == 'X', mask_str) |> powerset
    X_str = ([(b in p ? '1' : '0') for b in 1:36] for p in possible_X)
    X = join.(X_str) |> x -> parse.(Int, x, base = 2)
    return a, b, X
end

function parse_write(line)
    l, o = split(line, "=")
    addr = match(r"\d+", l).match |> x -> parse(Int, x)
    val = match(r"\d+", o).match |> x -> parse(Int, x)
    return addr, val
end

function mask(val, a, b)
    return (val|a) & b
end

function mask(addr, a, b, X::AbstractArray)
    return ((addr|a) & b) .| X
end

function part1(data = raw_data)
    # TODO test ImmutableDict
    lines = splitlines(data)
    mem = Dict{Int,Int}()
    a = b = 0
    for l in lines
        if startswith(l, "mask")
            a, b = parse_mask(l)
        elseif startswith(l, "mem")
            addr, val = parse_write(l)
            mem[addr] = mask(val, a, b) 
        else
            error("line in an unknown format")
        end
    end
    return sum(values(mem))
end

function part2(data = raw_data)
    lines = splitlines(data)
    mem = Dict{Int,Int}()
    a = b = 0
    X = Array{Int,1}()
    for l in lines
        if startswith(l, "mask")
            a, b, X = parse_addr_mask(l)
        elseif startswith(l, "mem")
            addr, val = parse_write(l)
            addrs = mask(addr, a, b, X)
            for a in addrs
                mem[a] = val
            end
        else
            error("line in an unknown format")
        end
    end
    return sum(values(mem))
end

function solve(data = raw_data)
    return (Part1=part1(data), Part2=part2(data))
end
end # module
