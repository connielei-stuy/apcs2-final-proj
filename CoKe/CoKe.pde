boolean startGame, endGame = false;

int difficulty = 0; //difficulty

TownHall th = new TownHall();
static Barrack bk = null;

ArrayList<Structure> structures = new ArrayList<Structure>();
ArrayList<Troop> troops = new ArrayList<Troop>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayPriorityQueue<Troop> training = new ArrayPriorityQueue<Troop>(); //implemented this in class Barrack. oops?

int sec; //controls monster spawn
int sect; //controls troop spawn

float gold = 500; //starting gold to spend

Structure currentStructure; //stores a structure 
State structureSelected; //stores a type of structure selected
State state; //stores a state of the mouse
String message = "";


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
  sect = second();
  background(0, 200, 255);
}

void draw() {
  if (endGame) {
    background(0);
    textSize(64);
    fill(255, 0, 0);
    text("GAME OVER", width/2-175, height/2);
  } else if (!startGame) {
    textSize(32); 
    fill(0);
    text("Click to start game!", width/2-150, height/2);
    if (mousePressed == true) {
      startGame = true;
    }
  } else {
    int sec2 = second(); //controls enemy spawn 
    if (sec -sec2 >= 2) {
      sec = second();
    }
    if (sec2-sec > 1) {
      enemies.add(new Enemy(0));
      sec = second();
    }
    if (bk != null && !bk.trainingQ.isEmpty()) {
      int sec3 = second();
      if (sec3-sect > bk.trainingQ.peekMin().getTime()) {
        troops.add(bk.trainingQ.removeMin());
      }
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
          //System.out.println("Cannon" + s.getHealth());
          //System.out.println(e.getHealth());
        }
      }
    }

    if (currentStructure != null) {
      structures.add(currentStructure);
      structures.get(structures.size()-1).display();
      structures.remove(structures.size()-1);
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
    int t = 0;
    while (t < troops.size()) {
      if (troops.get(t).getHealth() > 0) {
        troops.get(t).display();
        t ++;
      } else {
        troops.remove(t);
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
  rect(width-275, 0, 300, height/3);
  rect(0, 0, 275, height-200);
  fill(255, 245, 150);
  rect(0, height-200, 275, 200);
  fill(10, 150, 255);
  rect(width-275, height/3, 300, height/3);
  fill(100, 50, 200);
  rect(width-275, 2*(height/3), 300, height/3);
  textSize(20);
  fill(255, 250, 0);
  text("GOLD: " + gold, 30, 30);
  text("ENEMIES LEFT: " + enemies.size(), 30, 60);
  displayMessage();
}

void mouseDragged() {
  if (mouseX >= width-275 && !endGame && startGame) {
    state = State.STRUCTURESELECTED;
    if (mouseY < height/3.0) structureSelected = State.CANNON;
    if (mouseY > height/3.0 && mouseY < 2*(height/3.0)) structureSelected = State.WALL;
    if (mouseY > 2*(height/3.0)) structureSelected = State.BARRACK;
  }
  if (state == State.STRUCTURESELECTED) {
    if (structureSelected == State.CANNON) {
      //rect(mouseX-30,mouseY-30,60,60);
      currentStructure = new Cannon();
    }
    if (structureSelected == State.WALL) {
      //rect(mouseX-40,mouseY-10,80,20);
      currentStructure = new Wall();
    }
    if (structureSelected == State.BARRACK) {
      currentStructure = new Barrack();
    }
    //System.out.println("structure selected");
  }
}

void mouseReleased() {
  if (state == State.STRUCTURESELECTED) {
    state = State.NULL;
    message = canPlace(currentStructure, mouseX, mouseY); 
    if (message == "Structure successfully built") {
      structures.add(currentStructure);
      if (currentStructure.isA("barrack")) bk = new Barrack();
      gold -= currentStructure.getCost();
      for (Enemy e : enemies) {
        e.add(currentStructure);
      }
    }
    else {
      currentStructure = null;
    }
  }
}

void mouseClicked() {
  System.out.println(mouseY);
}

void mousePressed() {
}

void mouseWheel() {
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    for (Structure s : structures) {
      if (s.isA("wall")) {
        s.rotate();
      }//end if s.isA(wall)
    }//end for
  }//end if
  if (key == 't' || key == 'T') {
    if (bk != null) {
      bk.train();
      sect = second();
    } else message = "Cannot train: Build a barrack first";
  }
}//end 

//returns a message 
String canPlace(Structure s, float x, float y) { //s is the structure you want to place
  if (s.getCost() > gold) { 
    return "Cannot build: Insufficient gold";
  }
  if (x < 300+s.getWidth()/2 || x > width-300-s.getWidth()/2) return "Cannot build: Out of Bounds";
  if (y < 25+s.getHeight()/2 || y >height-25-s.getHeight()/2) return "Cannot build: Out of Bounds";
  if (s.isA("barrack") && bk != null) return "Cannot build: Barrack already built";
  //check if any of the four corners of the structure you want to place will be inside any structure 
  //returns false if any point is inside any structure
  for (Structure st : structures) {
    if (isInside(st, x-s.getWidth()/2, y+s.getHeight()/2) || //bl corner
      isInside(st, x-s.getWidth()/2, y-s.getHeight()/2) || //ul corner
      isInside(st, x+s.getWidth()/2, y+s.getHeight()/2) || //br corner
      isInside(st, x+s.getWidth()/2, y-s.getHeight()/2) || //ur corner
      isInside(st, x , y) )//center 
      return "Cannot build: On another structure";
  }
  return "Structure successfully built";
}

//checks if point is inside a structure
boolean isInside(Structure s, float x, float y) {
  if (x < s.getX()+s.getWidth() &&
    x > s.getX() &&
    y < s.getY()+s.getHeight() &&
    y > s.getY() )
    return true;
  return false;
}


//checks if an enemy is in the range of a structure
boolean inRange(Entity attacker, Entity target) {
  float distance = dist(attacker.getCX(), attacker.getCY(), target.getX(), target.getY());
  if (distance < attacker.getRange()/2 && distance != 0)
    return true;
  return false;
}

void displayMessage() {
  fill(0);
  textSize(14);
  text(message, 20, height-180);
}