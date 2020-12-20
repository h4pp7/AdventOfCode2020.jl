module Day19
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day19_input.txt"))

function solve(data = raw_input)
    (Part1=part1(data), Part2=part2(data))
end

function cyk(rules, word)
    n = length(word) 
    P = zeros(Bool, n, n, length(rules))
    
    for i in 1:n, (lhs, rhs) in rules, alt in rhs
        if length(alt) == 1 && rhs[1][1][1] == word[i]
            P[1,i,lhs+1] = true
        end
    end
    for l in 2:n # Length of span
        for s in 1:(n-l+1) # Start of span
            for p in 1:(l-1) # Partition of span
                for (lhs, rhs) in rules
                    for alt in rhs
                        if length(alt) == 2 
							(alt1, alt2) = alt
                            if P[p,s,alt1+1] && P[l-p,s+p,alt2+1]
                                P[l,s,lhs+1] = true
                            end
                        end
                    end
                end
            end
        end
    end
    if P[n,1,1]
        return true
    else
        return false
    end
end

function cnf(rules_str)
    # since my input (unlike the test input) ever only has two nonterminal
    # symbols, I don't need to replace anything on the rhs with new rules
    lines = splitlines(rules_str)
    rules = Dict()
    for l in lines
        lhs, rhs = split(l, ": ")
        alternatives = split(replace(rhs, "\"" => ""), " | ")
        rules[parse(Int, lhs)] = 
            [[if all(isdigit, c); parse(Int, c); else String(c) end for c in
              split(alt)] for alt in alternatives]
    end

    # TODO eliminate unit rules (A -> B where A,B are nonterminal)
	#=
    for (lhs, rhs) in rules 
       for alt in rhs
            if length(alt) == 1 && !(alt isa String)
            end
        end
    end
	=#
    return rules 
end

function read_rules(rules_str)
    lines = splitlines(rules_str)
    rules = Dict{String}{String}()
    for l in lines
        k, v = split(l, ": ")
        rules[k] = "(" * replace(v, "\"" => "") * ")"
    end
    return rules
end

function parse_rules(rules)
    while match(r"\d+", .*(values(rules)...)) != nothing
        for (k, v) in rules
            m = match(r"\d+", v)
            m == nothing && continue
            rules[k] = replace(v, m.match => rules[m.match], count = 1)
        end
    end
    return Regex(replace(rules["0"], " " => ""))
end

function part1(input = raw_input)
    rules_str, messages = split(input, "\n\n", keepempty = false)
    regex = read_rules(rules_str) |> parse_rules
    c = 0
    for message in splitlines(messages)
        m = match(regex, message)
        if m != nothing
            if m.match == message
                c += 1
            end
        end
    end
    return c
end

function part2(input = raw_input)
    missing
end
end # module
