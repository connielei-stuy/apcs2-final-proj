boolean startGame = false; //is the game started or not?
boolean endGame = false;
int difficulty = -1; //difficulty
TownHall th = new TownHall();
ArrayList<Structure> structures = new ArrayList<Structure>(); //arrayList that contains all the structures
ArrayList<Unit> troops = new ArrayList<Unit>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
int sec = second();
float gold = 500;


Structure currentStructure;
State state; //variable to store current state of the mouse

//enums for state of the mouse
//should add more later
public enum State {
  NULL, STRUCTURESELECTED
}

void setup() {
  size(1400, 825); //change this to fit the lab's computers 500/600
  frameRate(60); 
  stroke(255, 255, 0); //change color of outline of shapes
  structures.add(th); //required for every game
  //enemies.add(new Enemy());
  //enemies.add(new Enemy());
  sec = second();
}

void draw() {
  if (endGame) {
    background(0);
    textSize(64);
    fill(255, 0, 0);
    text("GAME OVER", 75, 300);
  } else if (!startGame) {
    background(0, 200, 255);
    textSize(32); 
    fill(0);
    text("Click to start game!", 175, 300);
    if (mousePressed == true) {
      startGame = true;
    }
  } else {
    int sec2 = second();
    if (sec2-sec > 5) {
      enemies.add(new Enemy());
      sec = second();
    }
    //System.out.println(th.getHealth());
    background(0, 255, 0); //0 for black, 255 for white
    fill(0, 255, 40);
    rect(width/2-500, height/2-382.5, 775, 775);
    fill(200, 0, 255);
    rect(width-250, 0, 250, height);
    if (difficulty < 0) {
      //program to allow user to choose difficult
    }

    for (Structure s : structures) {
      for (Enemy e : enemies) {
        if (inRange(s, e)) {
          s.attack(e);
          System.out.println("Cannon" + s.getHealth());
          System.out.println(e.getHealth());
        }
      }
    }

    //display every structure
    int s = 0;
    while (s < structures.size()) {
      if (structures.get(s).getHealth() > 0) {
        structures.get(s).display();
        s ++;
      } else {
        if (structures.get(s).equals(structures.get(0))) {
          endGame = true;
        }
        structures.remove(s);
      }
    }
    int e = 0;
    while (e < enemies.size()) {
      if (enemies.get(e).getHealth() > 0) {
        enemies.get(e).update();
        e ++;
      } else {
        gold += enemies.get(e).getGold();
        enemies.remove(e);
      }
    }
  }
}


void mouseDragged() {
  if (mouseY >= 500 && !endGame) {
    state = State.STRUCTURESELECTED;
  }
  if (state == State.STRUCTURESELECTED) {
    fill(color(200, 0, 255));
    rect(mouseX-40/2, mouseY-40/2, 40, 40);
    System.out.println("structure selected");
  }
}

void mouseReleased() {
  if (state == State.STRUCTURESELECTED) {
    currentStructure = new Cannon();
    state = State.NULL;
    if (canPlace(currentStructure, mouseX, mouseY)) {
      structures.add(currentStructure);
      for (Enemy u : enemies) {
        u.heaping();
      }
    }
  }
}

void mouseClicked() {
}

void mousePressed() {
}

void mouseWheel() {
}

boolean canPlace(Structure s, float x, float y) {
  if (y > 500-s.getHeight()/2) return false;
  if (x < 50+s.getWidth()/2 || x > 450-s.getWidth()/2) return false;
  if (y < 50+s.getHeight()/2 || y >450-s.getHeight()/2) return false;
  return true;
}

boolean inRange(Structure attacker, Enemy target) {
  float distance = dist(attacker.getX(), attacker.getY(), target.getX(), target.getY());
  if (distance < attacker.getRange()/2 && 
    distance != 0)
    return true;
  return false;
}