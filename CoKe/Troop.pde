class Troop extends Unit implements Comparable<Troop> {

  float _time, _priority; //takes 3 seconds to train a troop
  int _level;
  boolean inQueue;

  Troop() {
    if(difficulty == 0 || (difficulty == 1 && random(10) > 5)){
      setTroop(TROOPUPGRADES.get(1));
      _level = 1;
    }
    else{
      setTroop(TROOPUPGRADES.get(0));
      _level = 0;
    }
    defaults();
    heaping();
  }
  
  Troop(float maxHealth, float attack, float speed, float gold, float time, PImage north, PImage east, PImage south, PImage west) {
    _health = maxHealth;
    _maxHealth = maxHealth;
    _attack = attack;
    _speed = speed;
    _gold = gold;
    _time = time;
    _north = north;
    _east = east;
    _south = south;
    _west = west;
  }
  
  void setTroop(Troop copy){
    _maxHealth = copy.getMaxHealth() + random(50);
    _attack = copy.getAttack() +  random(10);
    _speed = copy.getSpeed() + random(1);
    _gold = copy.getGold();
    _time = copy.getTime();
    _north = copy.getNorth();
    _east = copy.getEast();
    _south = copy.getSouth();
    _west = copy.getWest();
  }

  void defaults() {
    _width = 20;
    _height  = 20;
    _state = 0;
    _health = _maxHealth;
    coordinates();
  }
  
  void coordinates(){
    _x = bk.getX()+random(bk.getWidth());
    _y = bk.getY()+bk.getHeight()+10;
    _centerX = _x;
    _centerY = _y;
  }
  
  void heaping() {
   targets = new ALHeap<Entity>(_x, _y);
   for (Entity e : enemies)
   targets.add(e);
  }

  float getTime() {
    return _time;
  }
  
  float getPriority(){
    return _priority;
  }

  void move() {
    //goes through its targets to check if target is still alive
    while (!targets.isEmpty() && targets.peekMin().getHealth() <= 0)
      targets.removeMin();

    //checks if target exists
    if (!targets.isEmpty()) {
      Entity nearest = targets.peekMin();

      float tempSpeed = _speed;

      float dis = dist(nearest.getX(), nearest.getY(), _x, _y);

      if (dis - 20 < _speed) {
        tempSpeed = dis - 20;
        _state = 1;
      } 

      _dx = tempSpeed * (nearest.getX() - _x) / dis;
      _dy = tempSpeed * (nearest.getY() - _y) / dis;

      _x += _dx; 
      _y += _dy; 
      _centerX = _x;
      _centerY = _y;

      if (abs(nearest.getX() - _x) - abs(nearest.getY() - _y) > 0) {//east, west
        if (nearest.getX() - _x > 0)
          photo = _east;
        else
          photo = _west;
      } else {//north, south
        if (nearest.getY() - _y > 0)
          photo = _south;
        else
          photo = _north;
      }
    }
  }

  float compareTo(Troop other){
     return _priority - other.getPriority();
  }
  
  void upgrade(){
    if(_time <= 0){
      setTroop(TROOPUPGRADES.get(_level + 1));
      _level ++;
      inQueue = false;
    }
  }
  
  boolean getInQueue(){
    return inQueue;
  }
  
  void setPriority(float priority){
    _priority = priority;
  }
  
  void time(float time){
    _time -= time;
  }

}