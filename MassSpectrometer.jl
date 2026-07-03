using CairoMakie
import LinearAlgebra: cross
function run_specterometer_simulation()
    # 1. Setup Data & Constants
    dt = 0.005
    total_steps = 3000

    # Ion properties (eg.,Isotope a and Isotope B )
    # using normalized /scaled values for clean Plotting
    q = 1.0
    masses = [1.2, 1.4]
    colors = [:deepskyblue, :tomato]
    labels = ["Isotope 12 (m=12)", "Isotope 14 (m=14)"]

    #Magnetic field in deflection chamber (pointing along +Y)
    B_field = [0.0, 0.0, 3.0]

# ---Layout---

# using 1x2 grid Layout
    fig = Figure(size = (1200, 600), font = "sans") 

# building the axis of the graph
    ax3D = Axis3(fig[1, 1],
    title = "3D helical Separation Analysis",
    xlabel = "X position (deflection Axis)",
    ylabel = "Y position (B-field Axis)",
    zlabel = "Z position (Drift Axis)",

    protrusions = (50, 30, 30, 30),
    # viewmode = :fitzoom,
    perspectiveness = 0.5,
    elevation = pi/12,
    azimuth = pi/2
    )
    

    gl_comparison = GridLayout(fig[1,2])

    ax_xy = Axis(gl_comparison[1, 1],
            title = "XY Projection (2r separation)",
            xlabel = "X position", ylabel = "Y position",
            aspect = DataAspect() 
    )
    hlines!(ax_xy, [0.0], color = :black, linestyle = :dash)


    ax_yz = Axis(gl_comparison[2, 1],
            title = "YZ projection  (Constant velocity Drift)",
            xlabel = "Y position", ylabel = "Z position",
            aspect = DataAspect()
            )
        
    for (i, m) = enumerate(masses) 
# setting initial values for position of x,y,Z
    pos = [0.0, 0.0 ,0.0]
# for velocity
    vel = [4.0, 0.0, 1.0]

# empty logs
    x_hist = Float64[]
    y_hist = Float64[]
    z_hist = Float64[]
        
        for step in 1:total_steps
            push!(x_hist, pos[1])
            push!(y_hist, pos[2])
            push!(z_hist, pos[3])

# formula 1.lorentzForce => Force = q(v x B)
            F_B = q .* cross(vel, B_field)

#         2.Force = mass * accl => accl = F/m
            accel = F_B ./ m

            vel .+= accel .* dt
            pos .+= vel .* dt

            # if pos[3] > 1.2 ||  pos[3] < -1.2
            #     break
            # end
        end

# -----Plotting the Data-------
    # The 3D path : The helical Trajectory 
        lines!(ax3D, x_hist, y_hist, z_hist, color = colors[i], linewidth = 3, label = labels[i])
    # Plot XY Projection (standard deflection Radius)
        lines!(ax_xy, x_hist, y_hist, color = colors[i], linewidth = 2)
    # Plot YZ Projection (projects  constant forward drift)
        lines!(ax_yz, y_hist, z_hist, color = colors[i], linewidth = 2)
    end
# -------Final Layout--------
    # 3D axis : Magnetic field direction indicator
        lines!(ax3D, [0.0, 0.0], [0.0, 1.0], [0.0, 0.0], color = :grey, linewidth = 4, linestyle = :dot )
        text!(ax3D, 0.0, 1.1, 0.0, text = "B-field Axis", color = :grey, align = (:center, :center))
        axislegend(ax3D, position = :lt)
        
        colgap!(fig.layout, 40)
        # save("3D_helical_spectrometer.png", fig)
    return fig 
end
run_specterometer_simulation()
