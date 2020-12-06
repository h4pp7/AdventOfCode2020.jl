module Test
using AdventOfCode2020
using Test

function runtests()
    @testset "Day 5" begin
        testdata = "FBFBBFFRLR\n" *
                   "BFFFBBFRRR\n" *
                   "FFFBBBFRRR\n" *
                   "BBFFBBFRLL\n"
       @test AdventOfCode2020.Day05.get_id("FBFBBFFRLR") == 357
       @test AdventOfCode2020.Day05.get_id("BFFFBBFRRR") == 567
       @test AdventOfCode2020.Day05.get_id("FFFBBBFRRR") == 119
       @test AdventOfCode2020.Day05.get_id("BBFFBBFRLL") == 820
       @test AdventOfCode2020.Day05.part1(testdata) == 820
    end
end
end # module
