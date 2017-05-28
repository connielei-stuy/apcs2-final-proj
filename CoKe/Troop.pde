class Troop extends Unit implements Comparable<Troop> {

  ALHeap<Entity> targets;
  int sec = second();
  float time = 3;
  Barrack home = CoKe.bk; //this is where a troop come from

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
    _x = home.getX()+random(home.getWidth());
    _y = home.getY()+home.getHeight()+10;
    state = 0;
  }

  void display() {
    fill(color(100, 50, 200));
    ellipse(_x, _y, 20, 20);
  }
  
  void update(){
    return ;
  }
  
  float getTime(){
    return time;
    
  }
  
  /*
  float compareTo(Troop other){
    return time - other.getTime();
  }*/
  
  int compareTo(Troop other){
    return 1;
  }
  
  void attack(){
   return ; 
  }

}