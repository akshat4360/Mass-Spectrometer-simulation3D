## 3D Mass Spectrometer Simulation
[Mass_Spectrometer.png]

Welcome to the **3D Mass Spectrometer Simulation** repository! the project features a high-fidelity computational Model of **BainBridge Mass Spectrometer** built using Julia and CairoMakie.

Going Beyond the standard of 2D physiics Models, this simulation integrates the third spaitial dimensions ($Z$-axis) to model the real-world particle dynamics capturing the precise helical trajectories that occurs when the ion possess the complex, multi-axis initial velocities.

## Core Physics & Mathematical Framework

A mass spectrometer separates the charged particles based on their mass-to-charge ($\frac{m}{q}$) ratio. 
The instrumentation isolates a specific velocity vector before deflecting the particles into the strutural orbits for the analytical detection.

### Velocity Selector Cross-Fields
In the initial chamber, perpendicular Electric($\vec{E}$) and Magnetic($\vec{B}_1$) fields creates an opposing force.
For a particle to to pass through the filtering slit undetected the Lorentz force must be zero.

$$\vec{F}_{\text{net}} = q (\vec{E} + \vec{v} \times \vec{B}_1) = 0$$

$$qE = qvB_1 \implies v = \frac{E} {B_1}$$
Only ions moving at this exact target velocity which is ($v$) enter the deflection chamber. 


### 2. 3D Helical Deflection Dynamics

Once inside the primary chamber , a uniform magnetic field ($\vec{B}_2$) is applied along a specific vector(eg:-...the $Z$ axis)the cross product dictates the orbital movement.

$$\vec{F} = q (\vec{v} \times \vec{B}_2) = m \vec{a}$$

*   **Perpendicular Velocity($v_{\perp}$):** Drives a perfect Circular orbit in the $XY$ plane with the radius directly proportinal to mass : $r = \frac{mv_{\perp}}{qB_2}$ .  
*   **Parallel Velocity ($v_{\parallel}$):** Experiences no magnetic force along the field vector, causing a constant linear drift that stretches the circle into a beautiful **3D Helix**

  ##  🛠️ Architecture: Components to Build the Simulation

The codebase is engineered around three clean, distinct modules

  ### 1. The 3D Kinematics Engine (`MassSpectrometer.jl`)
*   **Vector Dynamics:** Utilizes 3D linear algebra cross-products (`cross(vel, B_field)`) to continuously calculate the changing spatial direction of the magnetic force.
*   **Kinematic Stepper:** Implements an iterative time-stepping loop ($\Delta t$) to update acceleration, velocity, and position coordinates step-by-step.

### 2. Multi-View Analytics Dashboard (`CairoMakie`)
The visual layout uses an advanced grid system to render publication-ready vector graphics:
*   **Main 3D Axis:** Displays the interactive, overlapping 3D helical paths of distinct isotopes.
*   **XY Projection Plot:** Displays the classic structural mass separation axis (measuring $2r$).
*   **YZ Projection Plot:** Confirms the constant velocity drift along the magnetic field line.

### 3. Project Blueprint Dependencies
```julia
using CairoMakie       # Publication-quality plotting ecosystem
using LinearAlgebra    # Handles high-performance 3D vector operations


