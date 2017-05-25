class Cannon extends Structure {
  
  Cannon() {
    _health = 500;
    _defense = 50;
    _attack = 50;
    _range = 250;
    _width = 60;
    _height = 60;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
    c = color(200, 0, 255);
  }
  
}