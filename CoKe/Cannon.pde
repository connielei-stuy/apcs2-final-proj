class Cannon extends Structure {
  Cannon() {
    health = 500;
    defense = 50;
    attack = 50;
    range = 175;
    w = 40;
    h = 40;
    x = mouseX - w/2;
    y = mouseY - h/2;
    //x = 150;
    //y = 150;
    centerX = x+w/2;
    centerY = y+h/2;
    c = color(200, 0, 255);
  }
}