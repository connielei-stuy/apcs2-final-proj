class TownHall extends Structure {

  TownHall(float maxHealth, float attack, float range, float time, float gold, PImage townhall) {
    _maxHealth = maxHealth;
    _attack = attack;
    _range = range;
    _gold = gold;
    _time = time;
    photo = townhall;
    
    defaults();
  }

  void defaults() {
    ID = "townhall";
    _width = 80;
    _height = 80;
    _health = _maxHealth;
    _x = 1400/2 - _width/2;
    _y = 825/2 - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _width/2;
  }
  
  void upgrade(){ //placeholder, upgrade is done in CoKe
    return;
  }
}