class Cannon extends Structure {

  Cannon() {    
    if(difficulty == 0 || (difficulty == 1 && random(10) > 5)){
      setCannon(CANNONUPGRADES.get(1));
      _level = 1;
    }
    else{
      setCannon(CANNONUPGRADES.get(0));
      _level = 0;
    }
    defaults();
  }

  Cannon(float maxHealth, float attack, float range, float time, float gold, PImage cannon) {
    _maxHealth = maxHealth;
    _attack = attack;
    _range = range;
    _gold = gold;
    _time = time;
    photo = cannon;
  }

  void setCannon(Cannon copy){
    _maxHealth = copy.getMaxHealth();
    _attack = copy.getAttack();
    _range = copy.getRange();
    _gold = copy.getGold();
    _time = copy.getTime();
    photo = copy.getPhoto();
  }

  void defaults() {
    ID = "cannon";
    _health = _maxHealth;
    _width = 60;
    _height = 60;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
  }
<<<<<<< HEAD
  
  void upgrade(){
    if(_time <= 0){
      setCannon(CANNONUPGRADES.get(_level + 1));
      _level ++;
      inQueue = false;
    }
  }
=======
>>>>>>> e512e268609b577b7bd8076a420bdf1f23cb5cd0
}