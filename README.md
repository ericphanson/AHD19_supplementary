[![DOI](https://zenodo.org/badge/227002903.svg)](https://zenodo.org/badge/latestdoi/227002903)
[![arXiv article](https://img.shields.io/badge/article-arXiv%3A1912.05599-B31B1B)](https://arxiv.org/abs/1912.05599)

# AHD19 supplementary material

This repository contains supplementary code for [*A continuity bound for the expected number of connected components of a random graph: a model for epidemics*](https://arxiv.org/abs/1912.05599).

This code establishes that the function `f(x) = x - x^2 * M(x)` has a unique
maxima `x0` on the positive real line, and to establish bounds on `x0` and
`f(x0)`, using interval arithmetic. Here, `M(x)` is the Mills ratio of a
standard normal distribution.

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

Note: replacing the line

```julia
rs = roots(f_p, f_pp, 0.0..3.0, Newton, 1e-15)
```

in `main.jl` with

```julia
setprecision(BigFloat, 2000)
rs = roots(f_p, f_pp, big(0.0)..big(3.0), Newton, 1e-200)
```

gives the results to over 200 digits of precision (in under 20 seconds on a
laptop). With so many digits, it may be also more clear to change the formatting
by calling `setformat(:midpoint, sigfigs = 200)` instead of `setformat(:full)`.
The code can also be run interactively by starting a Julia session (with `julia --project=.`),
and then calling `include("main.jl")` to run the code. One can
check that e.g. the maximizer `x0` of `f` lies in an interval with midpoint

```julia
x0_midpoint = 1.1615278892744773670045950310963179055248173430096323424769955414382269171608731946077556127298357168401180625744295360417841176365395298299362693004595909274105907300177015449413811557016397489604206
```

and radius `10^(-200)`, and likewise the maximum value `μ = f(x0)` lies in an
interval with midpoint

```julia
μ_midpoint = 0.34681304709746665181959754576447769285509612047268959015695819176107030519709316551907071207639500027888189518938144470631572427308431734016794687095581930366434405144098077187902614048928981046477308
```

and radius `10^(-200)`.
