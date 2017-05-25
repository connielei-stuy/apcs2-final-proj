class TownHall extends Structure {

  TownHall() {
    health = 100;
    defense = 20;
    attack = 5;
    range = 160;
    w = 80;
    h = 80;
    x = 1400/2 - w/2;
    y = 825/2 - h/2;
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