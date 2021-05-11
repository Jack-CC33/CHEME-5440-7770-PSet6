using LaTeXStrings
using DifferentialEquations
using Plots
gr(show = true)

using Makie
using AbstractPlotting
using AbstractPlotting.MakieLayout
AbstractPlotting.inline!(true)

# Model parameters
α = 10
n = [1,2]

#--------  Collins Toggle Switch Model -------------

f1 = Figure(backgroundcolor = RGBf0(0.98, 0.98, 0.98),resolution = (800, 800))
ax1 = f1[1,1] = Axis(f1)
ax1.xlabel = "u"
ax1.ylabel = "v"

# Nullclines
x1 = collect(LinRange(0,1,50))
y1 = α ./ (1 .+ x1.^n[1])
line1 = lines!(ax1,x1,y1, color = (:green,0.9), linewidth = 1.5)

y2 = collect(LinRange(0,1,50))
x2 = α ./ (1 .+ y2.^n[1])
line2 = lines!(ax1,x2,y2, color = (:blue,0.9), linewidth = 1.5)

x3 = collect(LinRange(0,1,50))
y3 = α ./ (1 .+ x3.^n[2])
line3 = lines!(ax1,x3,y3, color = (:green,0.9), linewidth = 1.5, linestyle = "--")

y4 = collect(LinRange(0,1,50))
x4 = α ./ (1 .+ y4.^n[2])
line4 = lines!(ax1,x4,y4, color = (:blue,0.9), linewidth = 1.5, linestyle = "--")

axislegend(ax1,[line1,line3],["α=10, n=1","α=10, n=2"],"Conditions", position = :rc)
Makie.xlims!(ax1, [0.0, 1.0])
Makie.ylims!(ax1, [0.0, 1.0])
plt1 = f1.scene
ax1.title = "Collins Toggle Switch Nullclines"
display(f1)

# Plot 2
function Toggle_dynamics(u,v)
    α = 10
    n = 1
    du = α / (1 + v^n) - u
    dv = α / (1 + u^n) - v
    return Point(du, dv)
end

# Construct the streamplot
f2 = Figure(backgroundcolor = RGBf0(0.98, 0.98, 0.98),resolution = (800, 800))
ax2 = f2[1,1] = Axis(f2)
ax2.ylabel = "v"
ax1.xlabel = "u"
str2 = streamplot!(ax2, Toggle_dynamics, 0..1, 0..1, 1, colormap = :plasma, 
    gridsize= (50,50), arrow_size = 0.005)

# Add Nullclines
l1 = lines!(ax2,x1,y1, color = (:green,0.9), linewidth = 1.5)
l2 = lines!(ax2,x2,y2, color = (:blue,0.9), linewidth = 1.5)
l3 = lines!(ax1,x3,y3, color = (:green,0.9), linewidth = 1.5, linestyle = "--")
l4 = lines!(ax1,x4,y4, color = (:blue,0.9), linewidth = 1.5, linestyle = "--")

# Display the plot
axislegend(ax2,[l1,l2,l3,l4],["du/dτ=0, n=1","dv/dτ=0, n=1","du/dτ=0, n=2","dv/dτ=0, n=2"],"Nullclines", position = :rc)
Makie.xlims!(ax2, [0.0, 1.0])
Makie.ylims!(ax2, [0.0, 1.0])
plt2 = f2.scene
ax1.title = "Collins Toggle Switch Phase Portrait"
display(f2)

# Save the plot