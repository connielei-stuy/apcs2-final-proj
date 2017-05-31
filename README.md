CoKe: Connie Lei, Kevin Bao

<b>Project Title</b>:<br>
<b>What our project presents to a user</b>:<br>
Our project is a strategy game where a user has to defend a town hall by using
gold constructing structures and/or by training troops. These structures and
troops will attack incoming waves of enemies. If the town hall is destroyed,
the user loses the game.

<b>How our project works</b>:<br>
Arraylist: Arraylists are used to store structures, troops, and enemies.

Heap: Heaps are used to store the values of distances between a unit and each
opposing entity (structure/unit), where the smallest value is the root. This is
used for units to travel the shortest path to an opposing entity.

Stack: A stack is used to store enemies that will spawn in the wave after the
current wave.

PriorityQueue: A priorityQueue is used to store troops that are in-training. The
user can choose to give a troop priority over others, allowing this troop is be
trained before others in the priorityQueue.

<b>Launch Instructions</b>:<br>

1. Download the repo
```$ git clone https://github.com/kaybowwow/CoKe.git```

2. Use processing to run
```$ processing CoKe.pde```

OR

2. Open ```Coke.pde`` in the  ```Coke``` directory, contained in the root of this repo.

3. Press the triangle Run button.

[ANTHEM](https://www.youtube.com/watch?v=9DwzBICPhdM)
