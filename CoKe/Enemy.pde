class Enemy extends Unit {

  int target; //0 for structure, 1 for troop
  int _difficulty;

  Enemy(int difficulty) {
    _difficulty = difficulty;
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
      _health = 1000;
      _attack = random(20);
      _speed = random(5);
      _gold = 50;
    }
  }


  void defaults() {
    float r = random(100);
    if (r >= 0 && r <25) {
      _x = random(300, width-300);
      _y = 25;
    } else if (r >= 25 && r <50) {
      _x = width-300;
      _y = random(25, height-25);
    } else if (r >= 50 && r<75) {
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
    _centerX = _x;
    _centerY = _y;
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

  void move() {
    while (!targets.isEmpty() && targets.peekMin().getHealth() <= 0)
      targets.removeMin();

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
        if (temp.getCY() - _y > 0) { //south
          if (_difficulty == 0) {
            photo = loadImage("e_s.png");
          } else if (_difficulty == 2) {
            photo = loadImage("ee_s.png");
          } else {
            photo = loadImage("eee_s.png");
          }
        } else {//north
          if (_difficulty == 0) {
            photo = loadImage("e_n.png");
          } else if (_difficulty == 2) {
            photo = loadImage("ee_n.png");
          } else {
            photo = loadImage("eee_n.png");
          }
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
        if (temp.getCX() - _x > 0) { //east
          if (_difficulty == 0) {
            photo = loadImage("e_e.png");
          } else if (_difficulty == 2) {
            photo = loadImage("ee_e.png");
          } else {
            photo = loadImage("eee_e.png");
          }
        } else {//west
          if (_difficulty == 0) {
            photo = loadImage("e_w.png");
          } else if (_difficulty == 2) {
            photo = loadImage("ee_w.png");
          } else {
            photo = loadImage("eee_w.png");
          }
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

        if (min(values) == quadI) { //south west
          cornerY = topY;
          if (_difficulty == 0) {
            photo = loadImage("e_s.png");
            if (random(10) > 5) {
              photo = loadImage("e_e.png");
            }
          } else if (_difficulty == 2) {
            photo = loadImage("ee_s.png");
            if(random(10) > 5) {
              photo = loadImage("ee_e.png");
            }
          } else {
            photo = loadImage("eee_s.png");
            if (random(10) > 5) {
              photo = loadImage("eee_e.png");
            }
          }
        } else if (min(values) == quadII) { //south east
          cornerX = leftX;
          cornerY = topY;
          if (_difficulty == 0) {
            photo = loadImage("e_s.png");
            if (random(10) > 5) {
              photo = loadImage("e_w.png");
            }
          } else if (_difficulty == 2) {
            photo = loadImage("ee_s.png");
            if (random(10) > 5) {
              photo = loadImage("ee_w.png");
            }
          } else {
            photo = loadImage("eee_s.png");
            if (random(10) > 5) {
              photo = loadImage("eee_w.png");
            }
          }
        } else if (min(values) == quadIII) { //north east
          cornerX = leftX;
          if (_difficulty == 0) {
            photo = loadImage("e_n.png");
            if (random(10) > 5) {
              photo = loadImage("e_w.png");
            }
          } else if (_difficulty == 2) {
            photo = loadImage("ee_n.png");
            if (random(10) > 5) {
              photo = loadImage("ee_w.png");
            }
          } else {
            photo = loadImage("eee_n.png");
            if (random(10) > 5) {
              photo = loadImage("eee_w.png");
            }
          }
        } else { //north west
                  if (_difficulty == 0) {
            photo = loadImage("e_n.png");
            if (random(10) > 5) {
              photo = loadImage("e_e.png");
            }
          } else if (_difficulty == 2) {
            photo = loadImage("ee_n.png");
            if(random(10) > 5) {
              photo = loadImage("ee_e.png");
            }
          } else {
            photo = loadImage("eee_n.png");
            if (random(10) > 5) {
              photo = loadImage("eee_e.png");
            }
          }
        }

        dis = dist(cornerX, cornerY, _x, _y);

        float tempSpeed = _speed;

        if (dis - 10 < _speed) {
          tempSpeed = dis - 10;
          state = 1;
        }
        float hyp = dist(cornerX, cornerY, _x, _y);
        _dx = tempSpeed * (cornerX - _x) / hyp;
        _dy = tempSpeed * (cornerY - _y) / hyp;
      }

      _x += _dx; 
      _centerX += _dx;
      _y += _dy; 
      _centerY += _dy;
    }
  }

  void attack() {
    int tempSec = second();
    if (tempSec - sec > 2) {
      sec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }

  void add(Entity e) {
    targets.add(e);
  }
}