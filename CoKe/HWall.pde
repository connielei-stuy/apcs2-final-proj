class HWall extends Structure {

  HWall() {
    if(difficulty == 0 || (difficulty == 1 && random(10) > 5)){
      setWall(HWALLUPGRADES.get(1));
      _level = 1;
    }
    else{
      setWall(HWALLUPGRADES.get(0));
      _level = 0;
    }
    defaults();
  }

  HWall(float maxHealth, float gold, float time, PImage hwall){
    _maxHealth = maxHealth;
    _gold = gold;
    _time = time;
    photo = hwall;
  }

  void setWall(HWall copy){
    _maxHealth = copy.getMaxHealth();
    _gold = copy.getGold();
    _time = copy.getTime();
    photo = copy.getPhoto();
  }
  
  void defaults() {
    ID = "hwall";
    _health = _maxHealth;
    _attack = 0;
    _range = 0;
    _width = 60;
    _height = 20;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
  }
  
  void upgrade(){
    if(_time <= 0){
      setWall(HWALLUPGRADES.get(_level + 1));
      _level ++;
      inQueue = false;
    }
  }
}