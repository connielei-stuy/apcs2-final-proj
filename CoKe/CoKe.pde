boolean startGame = false; //is the game started or not?
int difficulty = -1; //difficulty
ArrayList<Structure> structures = new ArrayList<Structure>(); //arrayList that contains all the structures
ArrayList<Unit> troops = new ArrayList<Unit>();
ArrayList<Unit> enemies = new ArrayList<Unit>();

Structure currentStructure;
State state; //variable to store current state of the mouse
Unit test; //test unit

//enums for state of the mouse
//should add more later
public enum State {
  NULL, STRUCTURESELECTED
}

void setup() {
  size(500, 600); //change this to fit the lab's computers
  frameRate(60); 
  stroke(255, 255, 0); //change color of outline of shapes
  test = new Enemy();
  structures.add(new TownHall()); //required for every game
}

void draw() {
  if (!startGame) {
    background(0, 200, 255);
    textSize(32); 
    fill(0);
    text("Click to start game!", 100, 100);
    if (mousePressed == true) {
      startGame = true;
    }
  } else {
    background(0, 255, 0); //0 for black, 255 for white
    fill(0, 255, 40);
    rect(50, 50, 400, 400);
    fill(200, 0, 255);
    rect(0, 500, 500, 100);
    if (difficulty < 0) {
      //program to allow user to choose difficult
    }


    //display every structure
    for (Structure s : structures) {
      s.display();
      for (Structure s2 : structures) {
        if (inRange(s, s2)) {
          s.attack(s2);
        }
      }
    }
  }
}

void mouseDragged() {
  if (mouseY >= 500) {
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
    if (canPlace(currentStructure, mouseX, mouseY)) 
      structures.add(currentStructure);
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

boolean inRange(Structure attacker, Structure target) {
  float distance = dist(attacker.getX(), attacker.getY(), target.getX(), target.getY());
  if (distance < attacker.getRange()/2 && 
    distance != 0)
    return true;
  return false;
}