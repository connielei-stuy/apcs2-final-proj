class Troop extends Unit implements Comparable<Troop> {

  float _time, _priority; //takes 3 seconds to train a troop
  
  LLStack<Troop> temp;

  Troop() {
    troopSpawn();
    troopAdjust();
    setTroop();
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
  
  void troopSpawn(){
  temp = new LLStack<Troop>();
  temp.push(new Troop(700, 70, 4, -1, 15, loadImage("tttt_n.png"), loadImage("tttt_e.png"), loadImage("tttt_s.png"), loadImage("tttt_w.png")));
  temp.push(new Troop(450, 50, 3.5, 300, 10, loadImage("ttt_n.png"), loadImage("ttt_e.png"), loadImage("ttt_s.png"), loadImage("ttt_w.png")));
  temp.push(new Troop(250, 40, 2.5, 150, 7, loadImage("tt_n.png"), loadImage("tt_e.png"), loadImage("tt_s.png"), loadImage("tt_w.png")));
  temp.push(new Troop(150, 30, 2, 100, 5, loadImage("t_n.png"), loadImage("t_e.png"), loadImage("t_s.png"), loadImage("t_w.png")));
  }
 
  void troopAdjust(){
    if(difficulty == 0)
      temp.pop();
    if(difficulty != 2 && random(10) > 7)
      temp.pop(); 
  }
  
  void setTroop(){
    Troop copy = temp.pop();
    _maxHealth = copy.getMaxHealth();
    _attack = copy.getAttack();
    _speed = copy.getSpeed();
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

}