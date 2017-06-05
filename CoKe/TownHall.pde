class TownHall extends Structure {

  TownHall() {
    ID = "townhall";
    _health = 50000000;
    _attack = 5;
    _range = 160;
    _width = 80;
    _height = 80;
    _x = 1400/2 - _width/2;
    _y = 825/2 - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _width/2;
    c = color(255, 0, 0);
    photo = loadImage("townhall.png");
  }
}