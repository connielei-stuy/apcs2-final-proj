int difficulty = -1;
Unit test;
Structure deeznuts;

void setup(){
  size(500, 500); //change this to fit the lab's computers
  frameRate(60); 
  test = new Enemy();
  deeznuts = new TownHall();
  
  
}

void draw(){
  background(255); //0 for black, 255 for white  
  if(difficulty < 0){
    //program to allow user to choose difficult
    System.out.println("hello world");
  }
  deeznuts.display();
  
  //test.display();
}