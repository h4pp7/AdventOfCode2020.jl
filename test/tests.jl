module AoCtest
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
end # module
