# StraightOuttaSpace

This game is written in ActionScript 3. It is a vertical scrolling shooter and
based on similar games like 1945.


## Usage

You can compile this project for Web (with Adobe Flash Player) as well as for desktop or mobile devices (with Adobe AIR).
On desktop devices the snake can be controlled by the arrow keys. On mobile devices you can just tap on screen to change directions.

* Use the following compiler and libraries:
  * ADT 3.1.0.4880+
  * Flex SDK 4.6.0+
  * AIR-SDK 3.2+


### Controls

This game can be played via Keyboard:

* To move your spaceship use either W, A, S, D or the arrow keys.
* To shoot press SPACE.
* To pause the game press ENTER
* To exit the game press ESC


### Demo

A demonstration can be found under https://zzznake.p3337.de.



## High Score

The High Score is constantly updated. Currently only one record will be saved in
a flash cookie and restored for every new game instance.



## Opponents / AI

Currently the opponents are very stupid: They will shoot only once when they
appear and at a distance of about 400px to the players spaceship.
Their start position is set randomly. The number of opponent spaceships for
every attack is fixed for the first 25 waves, after that this will be set randomly.



## Resources

All resources are made by myself except for all spaceship and laser textures as
well as the sound samples. They are created by kenney.nl.



# License

These templates are licensed under the MIT License, see the [LICENSE](LICENSE) file for more information.
