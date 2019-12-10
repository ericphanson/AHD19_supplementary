# This file contains code taken from https://github.com/JuliaIntervals/IntervalSpecialFunctions.jl
# which is available under the following MIT license:

# > Copyright (c) 2018: David Sanders.
# >
# > Permission is hereby granted, free of charge, to any person obtaining a copy
# > of this software and associated documentation files (the "Software"), to deal
# > in the Software without restriction, including without limitation the rights
# > to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# > copies of the Software, and to permit persons to whom the Software is
# > furnished to do so, subject to the following conditions:
# >
# > The above copyright notice and this permission notice shall be included in all
# > copies or substantial portions of the Software.
# >
# > THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# > IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# > FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# > AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# > LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# > OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# > SOFTWARE.

using IntervalArithmetic
using IntervalArithmetic: @round, big53

import SpecialFunctions: erf, erfc, erfinv, erfcinv

for f in (:erf, :erfc)
    @eval function($f)(x::BigFloat, r::RoundingMode)
        setrounding(BigFloat, r) do
            ($f)(x)
        end
    end
    @eval ($f)(a::Interval{Float64}) = convert(Interval{Float64}, ($f)(big53(a)))
end

function erf(a::Interval{T}) where T
    isempty(a) && return a
    @round( erf(a.lo), erf(a.hi) )
end

function erfc(a::Interval{T}) where T
    isempty(a) && return a
    @round( erfc(a.hi), erfc(a.lo) )
end
