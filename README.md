# AHD19 supplementary material

This code establishes that the function `f(x) = x - x^2 * M(x)` has a unique
maxima `x0` on the positive real line, and to establish bounds on `x0` and
`f(x0)`, using interval arithmetic.

The code is written in the [Julia](https://julialang.org/) programming language,
and was run with Julia version 1.3. To replicate it, install Julia 1.3 and in
this folder, run the commands

```bash
julia --project=. -e "using Pkg; Pkg.instantiate()"
julia --project=. main.jl
```

The first line downloads the dependencies exactly as they are specified in the
`Manifest.toml` file. The second line runs the code. The expected output is:

```julia
We see there is a unique root:
Root{Interval{Float64}}[Root(Interval(1.1615278892744612, 1.1615278892744958), :unique)]
The root x0 occurs in the interval:
Interval(1.1615278892744612, 1.1615278892744958)
The value of f at x0 is in the interval:
Interval(0.3468130470973845, 0.346813047097549)
The value of f' at x0 is in the interval:
Interval(-2.2115642650533118e-13, 2.2115642650533118e-13)
The value of f'' at x0 is in the interval:
Interval(-0.16730889431005824, -0.16730889430876594)
```

This package uses
[IntervalRootFinding.jl](https://github.com/JuliaIntervals/IntervalRootFinding.jl),
[IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl),
and [SpecialFunctions.jl](https://github.com/JuliaMath/SpecialFunctions.jl).
