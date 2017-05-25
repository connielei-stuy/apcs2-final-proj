class Troop extends Unit implements Comparable<Troop> {

  ALHeap<Unit> uTarget;
  int sec = second();
  float time = 0;

  Troop() {
    setC(0);
    defaults();
  }

  Troop(int difficulty) {
    setC(difficulty);
    defaults();
  }

  void setC(int difficulty) {
    if (difficulty == 0) {
      health = 500;
      defense = random(30);
      attack = random(75);
      speed = 2;
    } else if (difficulty == 1) {
      health = 100;
      defense = random(20);
      attack = random(20);
      speed = random(5);
    } else if (difficulty  == 2) {
    } else if (difficulty == 3) {
    }
  }

  void defaults() {
    x = height/2;
    y = width/2;
    state = 0;
  }

  void display() {
    fill(color(14, 15, 200));
    ellipse(x, y, 20, 20);
  }
  
  void update(){
    return ;
  }
  
  float getTime(){
    return time;
    
  }
  
  float compareTo(Troop other){
    return time - other.getTime();
  }
  
  void attack(){
   return ; 
  }

}