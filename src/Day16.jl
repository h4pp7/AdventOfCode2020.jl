module Day16
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day16_input.txt"))
const rule_regex = r"(?'field'\D+)(?::\D+)(?'r1s'\d+)\-(?'r1e'\d+)\D+(?'r2s'\d+)\-(?'r2e'\d+)(?:\s+|$)"

function solve(data = raw_input)
    (Part1=part1(data), Part2=part2(data))
end

function parse_rules(rules_str)
    rules = Dict{String}{Tuple{UnitRange,UnitRange}}()
    get_rm(m) = [m["r1s"],m["r1e"],m["r2s"],m["r2e"]]::Vector{SubString{String}}
    for m in eachmatch(rule_regex, rules_str)
        r1s, r1e, r2s, r2e = parse.(Int, get_rm(m))
        rules[m["field"]] = ((r1s:r1e),(r2s:r2e))
    end
    return rules 
end

function parse_tickets(tickets_str)
    tickets = Vector{Vector{Int}}()
    for l in splitlines(tickets_str)
        startswith(l, r"\D") && continue
        push!(tickets, parse.(Int, split(l, ",")))
    end
    return tickets
end

function parse_input(input)
    rules_str, myticket_str, tickets_str = split(input, "\n\n")
    rules = parse_rules(rules_str)
    tickets = parse_tickets(tickets_str)
    _, myticket = splitlines(myticket_str)
    myticket = split(myticket, ",") |> x -> parse.(Int, x)
    return rules, tickets, myticket
end

function part1(input = raw_input)
    rules, tickets = parse_input(input)
    error_rate = mapreduce(+, tickets) do t
        sum(f for f in t if all(f .∉ Iterators.flatten(values(rules))))
    end
    return error_rate
end

function part2(input)
    rules, all_tickets, myticket = parse_input(input)
    tickets = filter(all_tickets) do t 
        !any(true for f in t if all(f .∉ Iterators.flatten(values(rules))))
    end

    matched = match_fields(rules, tickets)  

    myfields = [matched[n] for n in keys(matched) if startswith(n, "departure")]
    myvals = [myticket[k] for k in myfields]
    return reduce(*, myvals)
end

function match_fields(rules, tickets)
    possible_matches = Dict{Int}{Vector{String}}()
    matched = Dict{String}{Int}()
    for i in 1:20, k in keys(rules)
        if all(x -> any(x .∈ rules[k]), t[i] for t in tickets)
            possible_matches[i] = push!(get(possible_matches, i, String[]), k)
        end
    end
    while !isempty(possible_matches)
        for (i, labels) in possible_matches
            if length(labels) == 1
                label = labels[1]
                matched[label] = i
                pop!(possible_matches, i)
                for l in values(possible_matches)
                    setdiff!(l, [label])
                end
                break
            end
        end
    end
    return matched
end
end # module
