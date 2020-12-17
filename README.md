# AdventOfCode2020.jl

## Overview
Julia Package with my attempt at [Advent of Code 2020](https://adventofcode.com/2020/).
Just for fun and for learning Julia.

As a soft rule I'm trying to only use Base packages, since I want to learn the
language.

The commits with the first submitted correct solutions for each day are tagged
with git tags. `v0.1` for day 1, `v0.2` for day 2 etc.

## Day 17
I could reuse the core of Day 10, but simplified, because there are no cells,
who aren't alive or dead. Since I solved part 1 to work with arbitrary
dimensions, the second part only needed small changes. I'm growing the pocket
dim every step by 2. Would be nice if I could figure out a away to check the
"wall" cells, if any are alive and then grow only in that dimension. Haven't
found a way to do that and retain combatibility with arbitrary dimensions,
though. Maybe I can use [this idea](https://julialang.org/blog/2016/02/iteration/) for summing along a single
dimension...
