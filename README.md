3D Mass Spectrometer Simulation


Welcome to the **3D Mass Spectrometer Simulation** repository! the project features a high-fidelity computational Model of **BainBridge Mass Spectrometer** built using Julia and CairoMakie.

Going Beyond the standard of 2D physiics Models, this simulation integrates the third spaitial dimensions ($Z$-axis) to model the real-world particle dynamics capturing the precise helical trajectories that occurs when the ion possess the complex, multi-axis initial velocities.

##Core Physics & Mathematical Framework

A mass spectrometer separates the charged particles based on their mass-to-charge ($\frac{m}{q}$) ratio. 
The instrumentation isolates a specific velocity vector before deflecting the particles into the strutural orbits for the analytical detection.

### Velocity Selector Cross-Fields
In the initial chamber, perpendicular Electric($\vec{E}$) and Magnetic($\vec{B}_1$) fields creates an opposing force.
For a particle to to pass through the filtering slit undetected the Lorentz force must be zero.

$$\vec{F}_{\text{net}} = q (\vec{E} + \vec{v} \times \vec{B}_1) = 0$$

$$qE = qvB_1 \implies v = \frac{E} {B_1}$$
