boolean startGame = false; //is the game started or not?
int difficulty = -1;
Unit test;
Structure deeznuts;

//public enum state {
  
  

void setup(){
  size(500, 500); //change this to fit the lab's computers
  frameRate(60); 
  stroke(255,255,0);
  test = new Enemy();
  deeznuts = new TownHall();
  
  
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
    if(difficulty < 0){
      //program to allow user to choose difficult
      System.out.println("hello world");
    }
    deeznuts.display();  
  //test.display();
  }
}

  
  