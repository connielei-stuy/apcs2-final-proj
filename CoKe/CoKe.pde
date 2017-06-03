boolean startGame, endGame = false; //controls whether or not game has started/ended

int difficulty = 0; //difficulty: modifies stats of enemies

static Barrack bk = null; //contains the only barrack user is allowed to build

ArrayList<Structure> structures = new ArrayList<Structure>(); //stores all structures
ArrayList<Troop> troops = new ArrayList<Troop>(); //stores all troops
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //stores all enemies

int enemySec; //controls monster spawn
int troopSec; //controls troop spawn

float gold = 500; //starting gold to spend

Structure currentStructure; //stores a structure 
State structureSelected; //stores a type of structure selected (CANNON,WALL,BARRACK)
State state; //stores a state of the mouse(NULL,STRUCTURESELECTED)
String message = ""; //stores text that reflects latest action user has taken


//enums for state of the mouse
//should add more later
public enum State {
  NULL, STRUCTURESELECTED, CANNON, WALL, BARRACK
}

void setup() {
  size(1400, 825); //change this to fit the lab's computers 
  frameRate(60); 
  stroke(255, 255, 0); //change color of outline of shapes
  structures.add(new TownHall()); //required for every game
  enemySec = second(); //give enemySec a value
  troopSec = second(); //give troopSec a value
  background(0, 200, 255);
}

void draw() {
  if (endGame)
    endGame(); //GAMEOVER
  else if (!startGame)
    startGame();

  else {

    generate(); //generates the GUI
    structurePlacement();  //displays a structure that is being dragged around (hasn't been placed yet)
    enemySpawn(); //starts enemy spawnings

    //primitive troop training
    if (bk != null && !bk.trainingQ.isEmpty()) {
      int tempSec = second();
      if (tempSec-troopSec > bk.trainingQ.peekMin().getTime()) { //
        troops.add(bk.trainingQ.removeMin()); //remove troop from queue and add it to Arraylist troops
      }
    }

    //STRUCTURE DISPLAY
    //displays all structures if their health > 0
    //removes structures that have health <= 0
    //also checks endGame condition
    int s = 0;
    while (s < structures.size()) {
      if (structures.get(s).getHealth() > 0) {
        structures.get(s).update();
        s ++;
      } else {
        if (structures.get(s).isA("townhall"))
          endGame = true;
        structures.remove(s);
      }
    }

    //TROOP DISPLAY
    //displays all troops if their health > 0
    //removes troops that have health <= 0
    //updates troop movement, etc
    int t = 0;
    while (t < troops.size()) {
      if (troops.get(t).getHealth() > 0) {
        troops.get(t).update();
        t ++;
      } else {
        troops.remove(t);
      }
    }  

    //ENEMY DISPLAY
    //displays all enemies currently on the field with health > 0
    //removes enemies that have health <= 0
    //updates enemy movement, etc
    int e = 0;
    while (e < enemies.size()) {
      if (enemies.get(e).getHealth() > 0) {
        enemies.get(e).update();
        e ++;
      } else {
        //System.out.println(enemies.get(e)._gold);
        gold += enemies.get(e)._gold;
        enemies.remove(e);
      }
    }
    displayHealth(); //displays health of an entity when hovering over it
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
      currentStructure = new Cannon();
    }
    if (structureSelected == State.WALL) {
      currentStructure = new Wall();
    }
    if (structureSelected == State.BARRACK) {
      currentStructure = new Barrack();
    }
  }
}

void mouseReleased() {
  if (state == State.STRUCTURESELECTED) { //if you were dragging a structure
    state = State.NULL; //you are no longer dragging it since you released it
    message = canPlace(currentStructure, mouseX, mouseY); 
    if (message == "Structure successfully built") { //if you can place it here
      structures.add(currentStructure); //place it
      if (currentStructure.isA("barrack")) 
        bk = new Barrack();
      gold -= currentStructure.getGold(); //spend moneys
      for (Enemy e : enemies)
        e.add(currentStructure); //add this new structure to enemies' heap to keep track of
    } else
      currentStructure = null; //no structure is currently being dragged
  }
}

void mouseClicked() {
}

void mousePressed() {
}

void mouseWheel() {
}

void keyPressed() {
  //very primitive rotation for walls
  if (key == 'r' || key == 'R') {
    for (Structure s : structures) {
      if (s.isA("wall")) {
        s.rotate();
      }//end if s.isA(wall)
    }//end for
  }//end if
  //very primitive troop training
  if (key == 't' || key == 'T') {
    if (bk != null) { //if there is a barrack
      if (gold > 100 ) {
        bk.train();
        gold -= 100;
        troopSec = second();
      } else message = "Cannot train: insufficient gold";
    } else message = "Cannot train: Build a barrack first";
  }
}//end 

//returns a message 
String canPlace(Structure s, float x, float y) { //s is the structure you want to place
  if (s.getGold() > gold) { //enough moneys?
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
      isInside(st, x, y) )//center 
      return "Cannot build: On another structure";
  }
  return "Structure successfully built"; //yay
}

//checks if point is inside a structure
boolean isInside(Entity s, float x, float y) {
  if (x > s.getCX()-s.getWidth()/2 && //right of leftBound
    x < s.getCX()+s.getWidth()/2 && //left of RightBound
    y > s.getCY()-s.getHeight()/2 && //below upBound
    y < s.getCY()+s.getHeight()/2 ) //above lowBound
    return true;
  return false;
}

//displays text regarding user's latest action in message box
void displayMessage() {
  fill(0);
  textSize(14);
  text(message, 20, height-180);
}

//this happens when u lose
void endGame() {
  background(0);
  textSize(64);
  fill(255, 0, 0);
  text("GAME OVER", width/2-175, height/2);
}

//this is where user can choose a difficulty or start the game
void startGame() {
  //add difficulty choice 
  textSize(32); 
  fill(0);
  text("Click to start game!", width/2-150, height/2);
  if (mousePressed == true) //u clicked da mouse
    startGame = true;
}

//controls spawn rate of enemies
void enemySpawn() {
  int tempSec = second(); //controls enemy spawn 
  if (enemySec - tempSec >= 2)
    enemySec = second();
  if (tempSec - enemySec > 1) {
    enemies.add(new Enemy(0));
    enemySec = second();
  }
}

//if mouse is hovering over an entity, display its health
void displayHealth() {
  for (Structure s : structures) {
    if (isInside(s, mouseX, mouseY)) {
      fill(0);
      text("Health: " + s.getHealth(), s.getX(), s.getY());
    }
  }
  for (Enemy e : enemies) {
    if (isInside(e, mouseX, mouseY)) {
      fill(0);
      text("Health: " + e.getHealth(), e.getX()-5, e.getY()-10);
    }
  }
  for (Troop t : troops) {
    if (isInside(t, mouseX, mouseY)) {
      fill(0);
      text("Health: " + t.getHealth(), t.getX()-5, t.getY()-10);
    }
  }
}

void structurePlacement() {
  if (currentStructure != null) {
    structures.add(currentStructure); //add it
    structures.get(structures.size()-1).display(); //show it
    structures.remove(structures.size()-1); //remove it
  }
}