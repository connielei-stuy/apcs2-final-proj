class Enemy extends Unit {
  ALHeap<Structure> sTarget;
  ALHeap<Unit> uTarget;
  int target; //0 for structure, 1 for troop
  int sec = second();

  Enemy() {
    setC(0);
    defaults();
  }

  Enemy(int difficulty) {
    setC(difficulty);
    defaults();
  }

  void setC(int difficulty) {
    if (difficulty == 0) {
      health = 500;
      defense = random(30);
      attack = random(75);
      speed = 2;
    } else if (difficulty == 1) {
      health = 100;
      defense = random(20);
      attack = random(20);
      speed = random(5);
    } else if (difficulty  == 2) {
    } else if (difficulty == 3) {
    }
  }

  void defaults() {
    x = height-100-random(300);
    y = width;
    state = 0;
    target = 0;
    heaping();
  }

  void heaping() {
    sTarget = new ALHeap<Structure>(x, y);
    for (Structure s : structures) {
      sTarget.add(s);
    }
    uTarget = new ALHeap<Unit>(x, y);
    for (Unit troop : troops) {
      uTarget.add(troop);
    }
  }

  void display() {
    fill(color(14, 15, 200));
    ellipse(x, y, 20, 20);
  }

  void update() {    
    updateTarget();
    display();
    if (state == 1)
      attack();
    else
      move();
  }

  void move() {
    if (target == 0) { //targeting structure
      if (!sTarget.isEmpty()) {
        Structure temp = sTarget.peekMin();
        //System.out.println(sTarget);
        float hyp = dist(temp.getX(), temp.getY(), x, y);
        x += (speed * (temp.getX() - x) / hyp);
        y += (speed * (temp.getY() - y) / hyp);
        hyp = dist(temp.getX(), temp.getY(), x, y);
        if (hyp < (temp.getWidth() + 20)) {
          state = 1;
        }
      }
    } else {
      Unit temp = uTarget.peekMin();
      float hyp = dist(temp.getX(), temp.getY(), x, y);
      x += (speed * (temp.getX() - x) / hyp);
      y += (speed * (temp.getY() - y) / hyp);
      hyp = dist(temp.getX(), temp.getY(), x, y);
      if (hyp < (20 + 20)) {
        state = 1;
      }
    }
  }

  void updateTarget() {
    Unit uTemp = uTarget.peekMin();
    Structure sTemp = sTarget.peekMin();
    if (uTemp == null ||
      dist(uTemp.getX(), uTemp.getY(), x, y) > dist(sTemp.getX(), sTemp.getY(), x, y))
      target = 0;
    else
      target = 1;
  }

  void attack() {
    int sec2 = second();
    if (sec2-sec>2) {
      sec = second();
    if (target == 0) {
      Structure s = sTarget.peekMin();
      attack(s);
      if (s.getHealth() < 0) {
        sTarget.removeMin();
        state = 0;
      }
    } else {
      Unit u = uTarget.peekMin();
      attack(u);
      if (u.getHealth() < 0) {
        uTarget.removeMin();
        state = 0;
      }
    }
    }
  }
}