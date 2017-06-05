class Troop extends Unit implements Comparable<Troop> {

  float time = 3; //takes 3 seconds to train a troop
  Barrack home = CoKe.bk; //this is where a troop come from
  int _level;

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
      _attack = 1000;
      _speed = 2;
    } else if (difficulty == 1) {
      _health = 100;
      _attack = random(20);
      _speed = random(5);
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
    _gold = 100;
    _dx = 0;
    _dy = 0;
    _level = 0;
  }

  /*
  void heaping() {
   targets = new ALHeap<Entity>(_x, _y);
   for (Entity e : enemies)
   targets.add(e);
   }*/

  void display() {
    fill(color(100, 50, 200));
    ellipse(_x, _y, 20, 20);
  }

  float getTime() {
    return time;
  }

  //attacks nearest enemy every second
  void attack() {
    int tempSec = second();
    if (tempSec -sec > 1) {
      sec = second();
      attack(findNearestEnemy());
      if (findNearestEnemy().getHealth() < 0) {
        state = 0;
      }
    }
  }

  //moves to nearest enemy
  //troops can move through structures as troops are good guys :) whereas enemies are bad guys
  void move() {
    Enemy nearest = findNearestEnemy();
    float tempSpeed = _speed;
    float dis = dist(nearest.getX(), nearest.getY(), _x, _y);
    if (dis - 20 < _speed) {
      tempSpeed = dis - 20;
      state = 1;
    } 
    _dx = tempSpeed * (nearest.getX() - _x) / dis;
    _dy = tempSpeed * (nearest.getY() - _y) / dis;
    _x += _dx; 
    _centerX = _x;
    _y += _dy; 
    _centerY = _y;

    if (nearest.getX() - _x > 0) { //east
      if (abs(nearest.getX() - _x) - abs(nearest.getY() - _y) < 0) {
        if (nearest.getY() - _y > 0) {//south
          if (_level == 1) {
            photo = loadImage("tt_s.png");
          } else if (_level == 2) {
            photo = loadImage("ttt_s.png");
          } else if (_level == 3) {
            photo = loadImage("tttt_s.png");
          } else {
            photo = loadImage("t_s.png");
          }
        } else {//north
          if (_level == 1) {
            photo = loadImage("tt_n.png");
          } else if (_level == 2) {
            photo = loadImage("ttt_n.png");
          } else if (_level == 3) {
            photo = loadImage("tttt_n.png");
          } else {
            photo = loadImage("t_n.png");
          }
        }
      } else {
        if (_level == 1) {
          photo = loadImage("tt_e.png");
        } else if (_level == 2) {
          photo = loadImage("ttt_e.png");
        } else if (_level == 3) {
          photo = loadImage("tttt_e.png");
        } else {
          photo = loadImage("t_e.png");
        }
      }
    } else {//west
      if (abs(nearest.getX() - _x) - abs(nearest.getY() - _y) < 0) {
        if (nearest.getY() - _y > 0) {//south
          if (_level == 1) {
            photo = loadImage("tt_s.png");
          } else if (_level == 2) {
            photo = loadImage("ttt_s.png");
          } else if (_level == 3) {
            photo = loadImage("tttt_s.png");
          } else {
            photo = loadImage("t_s.png");
          }
        } else {//north
          if (_level == 1) {
            photo = loadImage("tt_n.png");
          } else if (_level == 2) {
            photo = loadImage("ttt_n.png");
          } else if (_level == 3) {
            photo = loadImage("tttt_n.png");
          } else {
            photo = loadImage("t_n.png");
          }
        }
      } else {
        if (_level == 1) {
          photo = loadImage("tt_w.png");
        } else if (_level == 2) {
          photo = loadImage("ttt_w.png");
        } else if (_level == 3) {
          photo = loadImage("tttt_w.png");
        } else {
          photo = loadImage("t_w.png");
        }
      }
    }
  }

  //finds and returns nearest enemy
  Enemy findNearestEnemy() {
    if (!enemies.isEmpty()) {
      Enemy retE = enemies.get(0);
      for (Enemy e : enemies) {
        if (dist(_x, _y, e.getX(), e.getY()) < dist(_x, _y, retE.getX(), retE.getY()))
          retE = e;
      }
      return retE;
    }
    return null;
  }


  int compareTo(Troop other) 
  {
    return 1;
  }
}