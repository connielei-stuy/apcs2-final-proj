//stats for Entity reference
//allows for balancing
//holds every possible "type" of Entity
static ArrayList<Enemy> ENEMYUPGRADES;
static ArrayList<Troop> TROOPUPGRADES;
static ArrayList<Barrack> BARRACKUPGRADES;
static ArrayList<Cannon> CANNONUPGRADES;
static ArrayList<HWall> HWALLUPGRADES;
static ArrayList<VWall> VWALLUPGRADES;

//every single entity in play
ArrayList<Structure> structures = new ArrayList<Structure>(); //stores all structures
ArrayList<Troop> troops = new ArrayList<Troop>(); //stores all troops
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //stores all enemies

//non changing structure
//reference stays the same even when properties change
static Barrack bk = null; //contains the only barrack user is allowed to build
static TownHall th = null; //contains the only town hall user is given upon spawn
static LLStack<TownHall> TOWNHALL;

boolean startGame; //controls whether or not game has started
float gold = 50000; //starting gold to spend
int difficulty = 0; //difficulty: modifies stats of enemies
int enemySec, troopSec, trainSec; //used for spawning 
String message = ""; //stores text that reflects latest action user has taken

//enums for state of the mouse
//should add more later
public enum State {
  NULL, STRUCTURESELECTED, CANNON, HWALL, VWALL, BARRACK
}
State structureSelected; //stores a type of structure selected (CANNON,WALL,BARRACK)
State state; //stores a state of the mouse(NULL,STRUCTURESELECTED)
Structure currentStructure; //stores a structure 

public enum Screens {
  TITLE, GAME, END, SETTINGS, PAUSE
}
Screens currentScreen = Screens.TITLE; //stores the enum value of the current screen
Screens previousScreen = null; //stores the enum value of the previous screen
Screen screen ; //stores the current screen


void setup() {
  size(1400, 825); //change this to fit the lab's computers 
  frameRate(60); 
  stroke(0); //change color of outline of shapes

  setTownHall();
  generateUpdates();

  enemySec = second(); //give enemySec a value
  troopSec = second(); //give troopSec a value
}

//----------------------------SETUP METHODS----------------------------\\
void setTownHall() {
  TOWNHALL = new LLStack<TownHall>();
  TOWNHALL.push(new TownHall(100000, 30, 185, 5, -1, loadImage("townhall10.png")));
  TOWNHALL.push(new TownHall(77000, 22, 177, 6, 2000, loadImage("townhall9.png")));
  TOWNHALL.push(new TownHall(35000, 18, 173, 7, 1700, loadImage("townhall8.png")));
  TOWNHALL.push(new TownHall(28000, 15, 170, 8, 1450, loadImage("townhall7.png")));
  TOWNHALL.push(new TownHall(25000, 13, 168, 9, 1300, loadImage("townhall6.png")));
  TOWNHALL.push(new TownHall(18000, 10, 165, 10, 950, loadImage("townhall5.png")));
  TOWNHALL.push(new TownHall(15000, 9, 164, 11, 850, loadImage("townhall4.png")));
  TOWNHALL.push(new TownHall(10000, 8, 163, 12, 750, loadImage("townhall3.png")));
  if (difficulty > 0) {
    TOWNHALL.push(new TownHall(8000, 7, 162, 13, 500, loadImage("townhall2.png")));
    if (difficulty == 2 || (random(10) > 5)) {
      TOWNHALL.push(new TownHall(5000, 6, 161, 14, 300, loadImage("townhall1.png")));
      if (difficulty == 2 || (random(10) > 5))
        TOWNHALL.push(new TownHall(1000, 5, 160, 15, 100, loadImage("townhall.png")));
    }
  }
  th = TOWNHALL.peek();
  structures.add(th);
}

void generateUpdates() {
  ENEMYUPGRADES = new ArrayList<Enemy>();
  ENEMYUPGRADES.add(new Enemy(150, 30, 2, 50, loadImage("e_n.png"), loadImage("e_e.png"), loadImage("e_s.png"), loadImage("e_w.png")));
  ENEMYUPGRADES.add(new Enemy(250, 40, 2.5, 80, loadImage("ee_n.png"), loadImage("ee_e.png"), loadImage("ee_s.png"), loadImage("ee_w.png")));
  ENEMYUPGRADES.add(new Enemy(500, 50, 3.5, 120, loadImage("eee_n.png"), loadImage("eee_e.png"), loadImage("eee_s.png"), loadImage("eee_w.png")));

  TROOPUPGRADES = new ArrayList<Troop>();
  TROOPUPGRADES.add(new Troop(150, 30, 2, 100, 5, loadImage("t_n.png"), loadImage("t_e.png"), loadImage("t_s.png"), loadImage("t_w.png")));
  TROOPUPGRADES.add(new Troop(250, 40, 2.5, 150, 7, loadImage("tt_n.png"), loadImage("tt_e.png"), loadImage("tt_s.png"), loadImage("tt_w.png")));
  TROOPUPGRADES.add(new Troop(450, 50, 3.5, 300, 10, loadImage("ttt_n.png"), loadImage("ttt_e.png"), loadImage("ttt_s.png"), loadImage("ttt_w.png")));
  TROOPUPGRADES.add(new Troop(700, 70, -1, -1, 15, loadImage("tttt_n.png"), loadImage("tttt_e.png"), loadImage("tttt_s.png"), loadImage("tttt_w.png")));

  BARRACKUPGRADES = new ArrayList<Barrack>();
  BARRACKUPGRADES.add(new Barrack(10000, 6, 300, loadImage("barrack.png")));
  BARRACKUPGRADES.add(new Barrack(15000, 7, 500, loadImage("barrack2.png")));
  BARRACKUPGRADES.add(new Barrack(10000, 8, 800, loadImage("barrack5.png")));
  BARRACKUPGRADES.add(new Barrack(10000, 9, 1100, loadImage("barrack7.png")));
  BARRACKUPGRADES.add(new Barrack(10000, 10, 1400, loadImage("barrack9.png")));

  CANNONUPGRADES = new ArrayList<Cannon>();
  CANNONUPGRADES.add(new Cannon(1000, 25, 100, 10, 150, loadImage("tower.png")));
  CANNONUPGRADES.add(new Cannon(2000, 45, 115, 8, 275, loadImage("tower1.png")));
  CANNONUPGRADES.add(new Cannon(3000, 65, 145, 7, 400, loadImage("tower2.png")));
  CANNONUPGRADES.add(new Cannon(4000, 85, 200, 6, 600, loadImage("tower3.png")));
  CANNONUPGRADES.add(new Cannon(5000, 100, 250, -1, -1, loadImage("tower4.png")));

  HWALLUPGRADES = new ArrayList<HWall>();
  HWALLUPGRADES.add(new HWall(1000, 150, 10, loadImage("wall.png")));
  HWALLUPGRADES.add(new HWall(2000, 300, 15, loadImage("wall.png")));
  HWALLUPGRADES.add(new HWall(3000, -1, -1, loadImage("wall.png")));

  VWALLUPGRADES = new ArrayList<VWall>();
  VWALLUPGRADES.add(new VWall(1000, 150, 10, loadImage("wall.png")));
  VWALLUPGRADES.add(new VWall(2000, 300, 15, loadImage("wall.png")));
  VWALLUPGRADES.add(new VWall(3000, -1, -1, loadImage("wall.png")));
}
//----------------------------SETUP METHODS----------------------------\\

void draw() {
  if (currentScreen == Screens.END)
    endScreen(); //GAMEOVER 
  else if (currentScreen == Screens.TITLE) {
    titleScreen();
  } else if (currentScreen == Screens.SETTINGS)
    settingsScreen();
  else if (currentScreen == Screens.PAUSE)
    pauseScreen();
  else {
    currentScreen = Screens.GAME;
    screen = null;
    generate(); //generates the GUI
    structurePlacement();  //displays a structure that is being dragged around (hasn't been placed yet)
    enemySpawn(); //starts enemy spawnings
    troopTraining();
    displayAll();
    if(bk != null){
      System.out.println("BARRACK HEALTH:" + bk.getMaxHealth());
    }
    //primitive troop training
    /*
    if (bk != null && !bk.trainingQ.isEmpty()) {
     int tempSec = second();
     if (tempSec-troopSec > bk.trainingQ.peekMin().getTime()) { //
     troops.add(bk.trainingQ.removeMin()); //remove troop from queue and add it to Arraylist troops
     }
     }*/
  }
}

//----------------------------GAME SCREEN FUNCTIONS----------------------------\\

void titleScreen() {
  screen = new TitleScreen();
  for (Button b : screen.buttons) {
    b.display();
  }
}

void settingsScreen() {
  screen = new SettingsScreen();
  textSize(32); 
  text("Difficulty: " + difficulty, width/2-80, height/3);     
  for (Button b : screen.buttons) {
    b.display();
  }
}

void pauseScreen() {
  screen = new PauseScreen();
  for (Button b : screen.buttons) {
    b.display();
  }
}

void endScreen() {
  screen = new EndScreen();
  for (Button b : screen.buttons) {
    b.display();
  }
}
//----------------------------GAME SCREEN FUNCTIONS----------------------------\\

//----------------------------GAME LOOP FUNCTIONS----------------------------\\
//generates the in-game GUI
void generate() {
  background(0, 255, 0); //0 for black, 255 for white
  fill(0, 255, 40);
  rect(312.5, height/2-387.5, 775, 775);   //the playing field
  fill(255, 245, 150);
  rect(0, height-200, 275, 200); //message box  
  fill(100);
  rect(0, 0, 275, height-200); //left purple column
  fill(0, 175, 255);
  cannonButton();
  hWallButton();
  vWallButton();
  barrackButton();
  textSize(20);
  fill(255, 250, 0);
  text("GOLD: " + gold, 30, 30);
  text("ENEMIES LEFT: " + enemies.size(), 30, 60);
  displayMessage();
}

void cannonButton() {
  rect(width-275, 0, 275, height/4); 
  image(loadImage("tower.png"), width-200, height/4-125);
}

void hWallButton() {
  rect(width-275, height/4, 275, height/4); 
  image(loadImage("wall.png"), width-212.5, 2*(height/4)-75, 120, 40);
}  

void vWallButton() {
  rect(width-275, 2*(height/4), 275, height/4); 
  image(loadImage("wall.png"), width-170, 3*(height/4)-125, 40, 120);
} 

void barrackButton() {
  rect(width-275, 3*(height/4), 275, height/4); 
  image(loadImage("barrack.png"), width-200, height-175, 100, 100);
}

//displays text regarding user's latest action in message box
void displayMessage() {
  fill(0);
  textSize(14);
  text(message, 20, height-180);
}

void structurePlacement() {
  if (currentStructure != null) {
    structures.add(currentStructure); //add it
    structures.get(structures.size()-1).display(); //show it
    structures.remove(structures.size()-1); //remove it
  }
}

//controls spawn rate of enemies
void enemySpawn() {
  int tempSec = second(); //controls enemy spawn 
  if (enemySec - tempSec >= 2)
    enemySec = second();
  if (tempSec - enemySec > 1) {
    enemies.add(new Enemy());
    enemySec = second();
  }
}

void troopTraining(){
  if(bk != null){
    bk.trainTroop();
  }
  trainSec = second();
}

void displayAll() {
  //STRUCTURE DISPLAY
  //displays all structures if their health > 0
  //removes structures that have health <= 0
  //also checks endGame condition
  int s = 0;
  while (s < structures.size()) {
    System.out.println(structures.size());
    if (structures.get(s).getHealth() > 0) {
      structures.get(s).update();
      s ++;
    } else {
      if (structures.get(s).isA("townhall"))
        currentScreen = Screens.END;
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

  System.out.println("got to this troop");

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
  displayHealth();
}

//if mouse is hovering over an entity, display its health
void displayHealth() {
  for (Structure s : structures) {
    if (isInside(s, mouseX, mouseY)) {
      //fill(0);
      //text("Health: " + s.getHealth(), s.getX(), s.getY());
      s.healthBar();
    }
  }
  for (Enemy e : enemies) {
    if (isInside(e, mouseX, mouseY)) {
      //fill(0);
      //text("Health: " + e.getHealth(), e.getX()-5, e.getY()-10);
      e.healthBar();
    }
  }
  for (Troop t : troops) {
    if (isInside(t, mouseX, mouseY)) {
      //fill(0);
      //text("Health: " + t.getHealth(), t.getX()-5, t.getY()-10);
      t.healthBar();
    }
  }
}
//----------------------------GAME LOOP FUNCTIONS----------------------------\\

//----------------------------MOUSE FUNCTIONS----------------------------\\
void mouseDragged() {
  if (mouseX >= width-275 && currentScreen == Screens.GAME) {
    state = State.STRUCTURESELECTED;
    if (mouseY < height/4.0) structureSelected = State.CANNON;
    if (mouseY > height/4.0 && mouseY < 2*(height/4.0)) structureSelected = State.HWALL;
    if (mouseY > 2*(height/4.0) && mouseY < 3*(height/4.0)) structureSelected = State.VWALL;    
    if (mouseY > 3*(height/4.0)) structureSelected = State.BARRACK;
  }
  if (state == State.STRUCTURESELECTED) {
    if (structureSelected == State.CANNON) {
      currentStructure = new Cannon();
    }
    if (structureSelected == State.HWALL) {
      currentStructure = new HWall();
    }
    if (structureSelected == State.VWALL) {
      currentStructure = new VWall();
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
      if (currentStructure.isA("barrack")){
        bk = new Barrack();
        structures.add(bk);
      }
      else
        structures.add(currentStructure); //place it
      gold -= currentStructure.getGold(); //spend moneys
      for (Enemy e : enemies)
        e.add(currentStructure); //add this new structure to enemies' heap to keep track of
    } else
      currentStructure = null; //no structure is currently being dragged
  }
}

void mouseClicked() {
  if (currentScreen != null && currentScreen != Screens.GAME) {
    for (Button b : screen.buttons) {
      if (b.overButton()) {
        String command = b.buttonMessage;
        screen.function(command);
      }
    }
  }
  if (currentScreen == Screens.GAME) {
    for (Structure s : structures) {
      if (isInside(s , mouseX , mouseY)) {
        if (s.isA("cannon")) {
          if (s.getGold() != -1) {
            if (gold >= CANNONUPGRADES.get(s.getLevel()).getGold()) {
              gold -= CANNONUPGRADES.get(s.getLevel()).getGold();                              
              s = CANNONUPGRADES.get(s.getLevel()+1);
              s._level++;
                            message= ""+s.getLevel();
              
            }
          }
        }
      }
    }
  }
}

void mousePressed() {
}

void keyPressed() {
  //very primitive rotation for walls
  if (key == 'r' || key == 'R') {
    for (Structure s : structures) {
      if (s.isA("hwall")) {
        s.rotate();
      }//end if s.isA(hwall)
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
  if (key == 'p' || key == 'P') {
    if (currentScreen == Screens.GAME) {
      currentScreen = Screens.PAUSE;
      previousScreen = Screens.GAME;
    }
  }
}//end 
//----------------------------MOUSE FUNCTIONS----------------------------\\

//----------------------------MOUSE HELPER FUNCTIONS----------------------------\\
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
  return(x > s.getCX()-s.getWidth()/2 && //right of leftBound
    x < s.getCX()+s.getWidth()/2 && //left of RightBound
    y > s.getCY()-s.getHeight()/2 && //below upBound
    y < s.getCY()+s.getHeight()/2 ); //above lowBound
}
//----------------------------MOUSE HELPER FUNCTIONS----------------------------\\