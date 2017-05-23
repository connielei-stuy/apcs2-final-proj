class TownHall extends Structure {

  TownHall() {
    health = 100;
    defense = 20;
    attack = 5;
    range = 100;
    w = 50;
    h = 50;
    x = 500/2 - w/2;
    y = 500/2 - h/2;
    centerX = x+w/2;
    centerY = y+w/2;
    c = color(255, 0, 0);
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  
  String toString(){
    return "Town Hall"; 
  }
}