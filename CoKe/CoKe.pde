export Structures;

boolean startGame, endGame = false;

int difficulty = -1; //difficulty

TownHall th = new TownHall();

ArrayList<Structure> structures = new ArrayList<Structure>();
ArrayList<Troop> troops = new ArrayList<Troop>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayPriorityQueue<Troop> training = new ArrayPriorityQueue<Troop>();

int sec = second();

float gold = 500;

Structure currentStructure;
State structureSelected;
State state; 


//enums for state of the mouse
//should add more later
public enum State {
  NULL, STRUCTURESELECTED, CANNON, WALL, BARRACK
}

void setup() {
  size(1400, 825); //change this to fit the lab's computers 500/600
  frameRate(60); 
  stroke(255, 255, 0); //change color of outline of shapes
  structures.add(th); //required for every game
  sec = second();
}

void draw() {
  if (endGame) {
    background(0);
    textSize(64);
    fill(255, 0, 0);
    text("GAME OVER", width/2-175, height/2);
  } else if (!startGame) {
    background(0, 200, 255);
    textSize(32); 
    fill(0);
    text("Click to start game!", width/2-150, height/2);
    if (mousePressed == true) {
      startGame = true;
    }
  } else {
    int sec2 = second();
    if (sec2-sec > 5) {
      enemies.add(new Enemy(0));
      sec = second();
    }
    //System.out.println(th.getHealth());
    generate();
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

void generate() {
    background(0, 255, 0); //0 for black, 255 for white
    fill(0, 255, 40);
    rect(312.5, height/2-387.5, 775, 775);  
    fill(200, 0, 255);
    rect(width-275, 0, 300, height/2);
    rect(0,0,275,height);  
    fill(10,150,255);
    rect(width-275,height/2,300,height/2);
}

void mouseDragged() {
  if (mouseX >= width-275 && !endGame && startGame) {
    state = State.STRUCTURESELECTED;
    if (mouseY < height/2) {structureSelected = State.CANNON;}
    if (mouseY > height/2) {structureSelected = State.WALL;}
  }
  if (state == State.STRUCTURESELECTED) {
    fill(color(200, 0, 255));
    rect(mouseX-40/2, mouseY-40/2, 40, 40);
    System.out.println("structure selected");
  }
}

void mouseReleased() {
  if (state == State.STRUCTURESELECTED) {
    if (structureSelected == State.CANNON) currentStructure = new Cannon();
    if (structureSelected == State.WALL) currentStructure = new Wall();
    state = State.NULL;
    if (canPlace(currentStructure, mouseX, mouseY)) {
      structures.add(currentStructure);
      for (Enemy e : enemies) {
        e.add(currentStructure);
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
  if (x > width-275-s.getHeight()/2) return false;
  if (x < 300+s.getWidth()/2 || x > width-300-s.getWidth()/2) return false;
  if (y < 25+s.getHeight()/2 || y >height-25-s.getHeight()/2) return false;
  for (Structure st : structures) {
    return  (checkLeftBound(st,x,y));
  }
  return true;
}

//returns false if invalid, true if valid
boolean checkLeftBound(Structure s , float x , float y) {
  for (Structure st : structures) {
    if (x-s.getWidth()/2 > st.getX() && x-s.getWidth()/2 < st.getX()+st.getWidth()) {
      return false;
    }
    if(y-s.getHeight()/2 > st.getY() && y-s.getHeight()/2 < st.getY()+st.getHeight())
      return false;
  }
  return true;
}



boolean inRange(Structure attacker, Enemy target) {
  float distance = dist(attacker.getCenterX(), attacker.getCenterY(), target.getX(), target.getY());
  if (distance < attacker.getRange()/2 && distance != 0)
    return true;
  return false;
}