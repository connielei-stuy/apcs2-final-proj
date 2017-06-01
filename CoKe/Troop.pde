class Troop extends Unit implements Comparable<Troop> {

  int sec = second();
  float time = 3;
  Barrack home = CoKe.bk; //this is where a troop come from

  Troop() {
    setC(0);
    defaults();
  }

  Troop(int difficulty) {
    setC(difficulty);
    defaults();
  }

  void setC(int difficulty) {
    if (difficulty == 0) {
      _health = 500;
      _defense = random(30);
      _attack = random(75);
      _speed = 2;
    } else if (difficulty == 1) {
      _health = 100;
      _defense = random(20);
      _attack = random(20);
      _speed = random(5);
    } else if (difficulty  == 2) {
    } else if (difficulty == 3) {
    }
  }

  void defaults() {
    _x = home.getX()+random(home.getWidth());
    _y = home.getY()+home.getHeight()+10;
    _centerX = _x;
    _centerY = _y;
    _width = 20;
    _height  = 20;
    state = 0;
    heaping();
  }

  void heaping() {
    targets = new ALHeap<Entity>(_x, _y);
    for (Entity e : enemies)
      targets.add(e);
  }

  void display() {
    fill(color(100, 50, 200));
    ellipse(_x, _y, 20, 20);
  }

  float getTime() {
    return time;
  }

  void move() {
    if (!targets.isEmpty()) {
      Entity temp = targets.peekMin();
      float _dx = 0, _dy = 0, dis = 0;

      dis = dist(temp.getCX(), temp.getCY(), _x, _y);

      if (dis - 10 < _speed) {
        _speed = dis - 10;
        state = 1;
      }

      float hyp = dist(temp.getCX(), temp.getCY(), _x, _y);
      _dx = _speed * (temp.getCX() - _x) / hyp;
      _dy = _speed * (temp.getCY() - _y) / hyp;

      _x += _dx;
      _y += _dy;
    }
  }
  
  
  void attack() {
    int tempSec = second();
    if (tempSec - troopSec > 2) {
      troopSec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }
  
  int compareTo(Troop other){
    return 1;    
  }
}