boolean startGame = false; //is the game started or not?
int difficulty = -1; //difficulty
ArrayList<Structure> structures = new ArrayList(); //arrayList that contains all the structures
State state; //variable to store current state of the mouse
Unit test; //test unit

//enums for state of the mouse
//should add more later
public enum State {
  NULL , STRUCTURESELECTED }
  
void setup(){
  size(500, 600); //change this to fit the lab's computers
  frameRate(60); 
  stroke(255,255,0); //change color of outline of shapes
  test = new Enemy();
  structures.add(new TownHall()); //required for every game
}

void draw(){
  if (!startGame) {
    background(0,200,255);
    textSize(32); fill(0);
    text("Click to start game!" , 100,100);
    if (mousePressed == true) {
      startGame = true;
    }
  }
  else{
    background(0,255,0); //0 for black, 255 for white
    fill(200,0,255);
    rect(0,500,500,100);
    if(difficulty < 0){
      //program to allow user to choose difficult
    }
    //display every structure
    for (Structure s : structures) {
      s.display();
    } 
  }
}

void mouseDragged() {
  if (mouseY >= 500) {
    state = State.STRUCTURESELECTED;
  }
  if (state == State.STRUCTURESELECTED) {
      fill(color(200,0,255));
      rect(mouseX-40/2,mouseY-40/2,40,40);
      System.out.println("structure selected");
  }
}

void mouseReleased() {
  if (state == State.STRUCTURESELECTED) {
    state = State.NULL;
    structures.add(new Cannon());
  }
}

void mouseClicked() {
}

void mousePressed() {
}

void mouseWheel() {
}

  
  