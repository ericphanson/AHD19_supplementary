using IntervalArithmetic, IntervalRootFinding, SpecialFunctions
setformat(:full)

include("IntervalSpecialFunctions.jl")

# Complementary error function
function Phi_c(x::T) where {T}
    invsqrt2 = inv(sqrt(T(2)))
    erfc(x * invsqrt2)/2
end

# Standard normal p.d.f.
function phi(x::T) where {T}
    invsqrt2π = inv(sqrt(2*T(π)))
    exp(-abs2(x)/2) * invsqrt2π
end

# The Mills ratio
M(x) = Phi_c(x)/phi(x)

# The function to maximize
f(x) = x - x^2 * M(x)

# The first derivative of f
f_p(x) = 1 + x^2  - x*(2+x^2)*M(x)

# The second derivative of f
f_pp(x) = x^3 + 4*x - M(x)*(2+5*x^2+x^4)

rs = roots(f_p, f_pp, 0.0..3.0, Newton, 1e-15)
x0_interval = interval(rs[1])

println("We see there is a unique root:")
println(rs)
println("The root x0 occurs in the interval:")
println(x0_interval)
println("The value of f at x0 is in the interval:")
println(f(x0_interval))
println("The value of f' at x0 is in the interval:")
println(f_p(x0_interval))
println("The value of f'' at x0 is in the interval:")
println(f_pp(x0_interval))
