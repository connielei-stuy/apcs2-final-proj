class Enemy extends Unit {
  
  ALHeap<Entity> targets;

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
      _defense = 0;
      _attack = random(75);
      _speed = 2;
      _gold = 30;
    } else if (difficulty == 1) {
      _health = 100;
      _defense = random(20);
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
      _x = random(300,width-300);
      _y = 25;
    }
    if (r >= 1 && r <2) {
      _x = width-300;
      _y = random(25,height-25);
    }
    if (r >= 2 && r<3) {
      _x = random(300,width-300);
      _y = height-25;
    }
    else {
      _x = 300;
      _y = random(25,height-25);
    }
    state = 0;
    target = 0;
    heaping();
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
    fill(color(14, 15, 200));
    ellipse(_x, _y, 20, 20);
  }

  void update() {    
    display();
    if (state == 1)
      attack();
    else
      move();
  }

  void move() {
    Entity temp = targets.peekMin();
    float hyp = dist(temp.getX(), temp.getY(), _x, _y);
    float _dx = _speed * (temp.getX() - _x) / hyp;
    float _dy = _speed * (temp.getY() - _y) / hyp;
    _x += _dx;
    _y += _dy;
    hyp = dist(temp.getX(), temp.getY(), _x, _y);

    //if (hyp < (temp.getWidth() + 20)) {
    //  state = 1;
    //}
  }

  void attack() {
    int sec2 = second();
    if (sec2 - sec > 2) {
      sec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }
  
  void add(Entity e){
   targets.add(e); 
  }

}