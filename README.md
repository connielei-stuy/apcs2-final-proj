<b>Project: CoKe: A Game</b><br>
by Team CoKe: Connie Lei, Kevin Bao
<b>What is it?</b><br>
Our project is a strategy game where a user has to defend a town hall by using
gold to construct structures and/or by using gold to train troops. These
structures and troops will attack incoming enemies. If the town hall is
destroyed, the user loses the game.

<b>How our project works</b>:<br>
There are 3 main classes in our project: Structure, Troop, and Enemy. Enemies
are mobile creatures that you want to defend against. Structures are stationary
buildings that may shoot bullets, deter enemies, or train troops. Troops are
friendly mobile allies who target and destroy enemies.

The Enemies and Troops are both AIs. An Enemy keeps track of every Structure and
Troop by storing their distances from the Enemy in a heap. This way, an Enemy
always moves to its nearest Structure or Troop to attack. A Troop only needs to
keep track of the nearest enemy, not every enemy. The difference in the Enemy
and Troop pathfindings is that an Enemy cannot walk through structures whereas
a Troop can.

There are also Screen classes in our project that either display a fully
functional Title Screen, Game Screen, Pause Screen, Settings Screen, or End
Screen. Most of the screens have buttons which are used to execute certain
commands from the GUI.

<b>Launch Instructions</b>:<br>

1. ```$ cd CoKe```
2. ```$ processing CoKe.pde```
3. Press the triangle play button in processing
4. The program's buttons will guide you, while in game, press P to pause.

[ANTHEM](https://www.youtube.com/watch?v=9DwzBICPhdM)
