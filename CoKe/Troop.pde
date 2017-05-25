class Troop extends Unit implements Comparable<Troop> {

  ALHeap<Entity> targets;
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
      _health = 500;
      _defense = random(30);
      _attack = random(75);
      _speed = 2;
    } else if (difficulty == 1) {
      _health = 100;
      _defense = random(20);
      _attack = random(20);
      _speed = random(5);
    } else if (difficulty  == 2) {
    } else if (difficulty == 3) {
    }
  }

  void defaults() {
    _x = height/2;
    _y = width/2;
    state = 0;
  }

  void display() {
    fill(color(14, 15, 200));
    ellipse(_x, _y, 20, 20);
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