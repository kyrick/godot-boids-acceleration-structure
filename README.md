# Boids in Godot with Acceleration Structure

This is my second attempt at boids in godot. I've implemented an acceleration structure which is a spatial partitioning scheme which optimizes the nearest neighbor lookups. All boid locations are stored in a 2D grid which represets the space. The boids query the structure to the cells in it's vacinity. The boids then filter that list based on their view range. This way the boid isn't looping over the entire list of neighbors. It's only concered with it's immedaite surroundings.

For more information on boids see [Craig Reynolds Boids](https://en.wikipedia.org/wiki/Boids). A more detailed breakdown of [Boids with pseudocode can be found here](http://www.kfish.org/boids/pseudocode.html).

# Running the Demo

Click F5 to run the default scene

Controls: 
* left click - place target flag
* right click - delete target.
* space - toggle controls UI
* escape - exit

# Credits

- GUI borrowed from [RKelln's fork of this repo](https://github.com/RKelln/godot-boids-acceleration-structure/tree/jackson). They added a lot of amazing special effects! Check it out it's very cool! 
- This project uses the [FarmPuzzleAnimals](https://comigo.itch.io/farm-puzzle-animals) pack created by [CoMiGo](https://comigo.itch.io/)  
