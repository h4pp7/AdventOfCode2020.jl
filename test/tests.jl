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

#=
function day11()
    @testset "Day 5" begin
        testinput = readinput("testinput") |> AdventOfCode2020.Day11.parse_floorplan
        test1 = readinput("test1")|> AdventOfCode2020.Day11.parse_floorplan
        test2 = readinput("test2")|> AdventOfCode2020.Day11.parse_floorplan
        test3 = readinput("test3")|> AdventOfCode2020.Day11.parse_floorplan
        test4 = readinput("test4")|> AdventOfCode2020.Day11.parse_floorplan
        test5 = readinput("test5")|> AdventOfCode2020.Day11.parse_floorplan

        @test AdventOfCode2020.Day11.init_seats(testinput) == test1
        @test AdventOfCode2020.Day11.(testinput) == test1
    end
end
=#
end # module
