class Wall extends Structure {
  
  Wall() {
    _health = 500;
    _defense = 80;
    _attack = 0;
    _range = 0;
    _width = 80;
    _height = 20;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
    c = color(200, 0, 255);
    cost = 100;
  }
  
}