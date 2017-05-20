class Cannon extends Structure {
  
  Cannon() {
    health = 300;
    defense = 30;
    attack = 50;
    w = 40;
    h = 40;
    x = mouseX - w/2;
    y = mouseY - h/2;
    c = color(200,0,255);
  }
}
  