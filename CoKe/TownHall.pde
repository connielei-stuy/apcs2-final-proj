class TownHall extends Structure {
  
  TownHall() {
    health = 1000;
    defense = 20;
    attack = 10;
    w = 50;
    h = 50;
    x = 500/2 - w/2;
    y = 500/2 - h/2;
  }
  
  void display() {
    fill (color (120,0,0));
    rect(x,y,w,h);
  }
}