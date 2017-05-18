int difficulty = -1;
Unit test;

void setup(){
  size(500, 500); //change this to fit the lab's computers
  frameRate(60); 
  test = new Enemy();
}

void draw(){
  if(difficulty < 0){
    //program to allow user to choose difficult
    System.out.println("hello world");
  }
  background(255); //0 for black, 255 for white
  test.display();
}