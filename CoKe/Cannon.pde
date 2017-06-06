class Cannon extends Structure {
  
  Cannon() {
    ID = "cannon";
    _health = 400;
    _attack = 25;
    _range = 250;
    _width = 60;
    _height = 60;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
    _gold = 200;
    photo = loadImage("cannon.png");
  }
  
}