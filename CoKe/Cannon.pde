class Cannon extends Structure {
  Cannon() {
    health = 500;
    defense = 50;
    attack = 50;
    range = 250;
    w = 60;
    h = 60;
    x = mouseX - w/2;
    y = mouseY - h/2;
    centerX = x+w/2;
    centerY = y+h/2;
    c = color(200, 0, 255);
  }
}