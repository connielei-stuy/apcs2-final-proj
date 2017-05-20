class TownHall extends Structure {
  
  TownHall() {
    health = 1000;
    defense = 20;
    attack = 10;
    w = 50;
    h = 50;
    x = 500/2 - w/2;
    y = 500/2 - h/2;
    c = color(255,0,0);
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
}