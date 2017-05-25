class TownHall extends Structure {

  TownHall() {
    _health = 100;
    _defense = 20;
    _attack = 5;
    _range = 160;
    _width = 80;
    _height = 80;
    _x = 1400/2 - _width/2;
    _y = 825/2 - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _width/2;
    c = color(255, 0, 0);
  }
  
  String toString(){
    return "Town Hall"; 
  }
}