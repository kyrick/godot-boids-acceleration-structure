# Boids in Godot with Acceleration Structure

This is my second attempt at boids in godot. I implemented an acceleration strcuture to optimize the nearest neighbor lookups. All boid locations are stored in a 2D which represets the space. The boids query the structure to get 4 cells based on the facing of the boids. The boids then filter that list based on their view range. This way the boid isn't looping over the entire list of boids. It's only concered with it's immedaite surroundings. 

I also slowed the physics engine down to 10 Hz. I wasn't able to run at 60 FPS with the physics server running at 60 hz.


For more information on boids see [Craig Reynolds Boids](https://en.wikipedia.org/wiki/Boids). A more detailed breakdown of [Boids with pseudocode can be found here](http://www.kfish.org/boids/pseudocode.html).

# Running the Demo

Click F5 to run the default screen. Then click anywhere on the screen to issue a waypoint for the boids. The boids will continue to chase mouse clicks.

Controls: 
* left click - place target flag
* right click - scatter the boids to random locations on the screen.

# Adjusting the simulation

You can control the paremeters of the simulation in the editor.

The Crow scene script variables:
* View distance - distance to view flock for each Boid
* Avoid distance - the distance at which a void will try to avoid another boid
* Max Speed - the maximum speed of the boid
* Force - There is a seperate force for each vector: cohesion, separation, alignment and mouse follow. Try playing with them :) 

The RandomBoids scene script variables:
* Boids - the number of boids that will spawn
* Boid - the boid scene. There are three scenes: Boids (the original chickens), Crows, and Bats.

# Credits

This project uses the [FarmPuzzleAnimals](https://comigo.itch.io/farm-puzzle-animals) pack created by [CoMiGo](https://comigo.itch.io/)  
