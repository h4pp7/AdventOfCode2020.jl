module Test
using AdventOfCode2020
using Test

function day05()
    @testset "Day 5" begin
        testdata1 = "FBFBBFFRLR\n" *
                   "BFFFBBFRRR\n" *
                   "FFFBBBFRRR\n" *
                   "BBFFBBFRLL\n"

        testdata2 = "FFFFFFFLLR\n" *
                    "FFFFFFFLRL\n" *
                    "FFFFFFFLRR\n" *
                    "FFFFFFFRLL\n" *
                    "FFFFFFFRRL\n" *
                    "FFFFFFFRRR\n" *

        @test AdventOfCode2020.Day05.part1(testdata1) == 820
        @test AdventOfCode2020.Day05.part2(testdata2) == 5
    end
end

function day07()
    @testset "Day 7" begin
        testdata = "light red bags contain 1 bright white bag, 2 muted yellow bags.\n" *
        "dark orange bags contain 3 bright white bags, 4 muted yellow bags.\n" *
        "bright white bags contain 1 shiny gold bag.\n" *
        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.\n" *
        "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.\n" *
        "dark olive bags contain 3 faded blue bags, 4 dotted black bags.\n" *
        "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.\n" *
        "faded blue bags contain no other bags.\n" *
        "dotted black bags contain no other bags.\n"

        testdata2 = "shiny gold bags contain 2 dark red bags.\n" *
                    "dark red bags contain 2 dark orange bags.\n" *
                    "dark orange bags contain 2 dark yellow bags.\n" *
                    "dark yellow bags contain 2 dark green bags.\n" *
                    "dark green bags contain 2 dark blue bags.\n" *
                    "dark blue bags contain 2 dark violet bags.\n" *
                    "dark violet bags contain no other bags.\n"

        testrule = "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
        @test AdventOfCode2020.Day07.parse_rules(testrule) == Dict("muted yellow" => ["shiny gold", "faded blue"])
        @test AdventOfCode2020.Day07.part1("shiny gold", testdata) == 4
        @test AdventOfCode2020.Day07.findbagcontents("shiny gold", AdventOfCode2020.splitlines(testdata)) == (["dark olive", "vibrant plum"], 3)
    end
end
end # module
