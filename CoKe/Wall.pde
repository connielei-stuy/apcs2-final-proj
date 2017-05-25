class Wall extends Structure {
  Wall() {
    health = 500;
    defense = 80;
    attack = 0;
    range = 0;
    w = 80;
    h = 20;
    x = mouseX - w/2;
    y = mouseY - h/2;
    centerX = x+w/2;
    centerY = y+h/2;
    c = color(200, 0, 255);
  }
}