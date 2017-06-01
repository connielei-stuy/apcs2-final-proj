class Enemy extends Unit {

  protected float _gold;
  int target; //0 for structure, 1 for troop
  int sec = second();

  Enemy(int difficulty) {
    setC(difficulty);
    defaults();
  }

  void setC(int difficulty) {
    if (difficulty == 0) {
      _health = 100;
      _attack = random(75);
      _speed = 2;
      _gold = 30;
    } else if (difficulty == 1) {
      _health = 100;
      _attack = random(20);
      _speed = random(5);
      _gold = 50;
    } else if (difficulty  == 2) {
    } else if (difficulty == 3) {
    }
  }

  float getGold() {
    return _gold;
  }

  void defaults() {
    float r = random(4);
    if (r >= 0 && r <1) {
      _x = random(300, width-300);
      _y = 25;
    }
    if (r >= 1 && r <2) {
      _x = width-300;
      _y = random(25, height-25);
    }
    if (r >= 2 && r<3) {
      _x = random(300, width-300);
      _y = height-25;
    } else {
      _x = 300;
      _y = random(25, height-25);
    }
    state = 0;
    target = 0;
    heaping();
    _width = 20;
    _height  = 20;
  }

  void heaping() {
    targets = new ALHeap<Entity>(_x, _y);
    for (Structure st : structures) {
      targets.add(st);
    }
    for (Troop tr : troops) {
      targets.add(tr);
    }
  }

  void display() {
    fill(color(255, 0, 255));
    ellipse(_x, _y, 20, 20);
  }

  void move() {
    if (!targets.isEmpty()) {
      Entity temp = targets.peekMin();

      float _dx = 0, _dy = 0, dis = 0;

      if (temp.getCX() - temp.getWidth()/2 <= _x && _x <= temp.getCX() + temp.getWidth()/2) {
        _dx = 0;
        _dy = _speed * (temp.getCY() - _y) / abs(temp.getCY() - _y);
        dis = abs(temp.getCY() - _y) - temp.getHeight()/2;
        if (dis - 10 < _speed) {
          _dy = dis - 10;
          state = 1;
        }
      }
      //chose what side like top or bot
      else if (temp.getCY() - temp.getHeight() /2 < _y && _y <= temp.getCY() + temp.getHeight()/2) {
        _dy = 0;
        _dx = _speed * (temp.getCX() - _x)/ abs(temp.getCX() - _x);
        dis = abs(temp.getCX() - _x) - temp.getWidth()/2;
        if (dis - 10 < _speed) {
          _dx = dis - 10;
          state = 1;
        }
      }
      //chose what side like right or left

      else {
        float topY = temp.getCY() - temp.getHeight()/2;
        float botY = temp.getCY() + temp.getHeight()/2;
        float rightX = temp.getCX() - temp.getWidth()/2;
        float leftX = temp.getCX() + temp.getWidth()/2;

        float quadI = dist(_x, _y, rightX, topY);
        float quadII = dist(_x, _y, leftX, topY);
        float quadIII = dist(_x, _y, leftX, botY);
        float quadIV = dist(_x, _y, rightX, botY);
        float[] values = {quadI, quadII, quadIII, quadIV};

        float cornerX = rightX;
        float cornerY = botY;

        if (min(values) == quadI) {
          cornerY = topY;
        } else if (min(values) == quadII) {
          cornerX = leftX;
          cornerY = topY;
        } else if (min(values) == quadIII) {
          cornerX = leftX;
        }

        dis = dist(cornerX, cornerY, _x, _y);

        if (dis - 10 < _speed) {
          _speed = dis - 10;
          state = 1;
        }
        float hyp = dist(cornerX, cornerY, _x, _y);
        _dx = _speed * (cornerX - _x) / hyp;
        _dy = _speed * (cornerY - _y) / hyp;
      }

      _x += _dx;
      _y += _dy;
    }
  }

  void add(Entity e) {
    targets.add(e);
  }
  
  void attack() {
    int tempSec = second();
    if (tempSec - enemySec > 2) {
      enemySec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }
}