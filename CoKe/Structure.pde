class Structure implements Location<Structure> {

  protected float health, defense, attack, range, w, h, x, y, centerX, centerY;
  protected color c;
  protected Bullet b = null;
  int sec = second();

  float getHealth() {
    return health;
  }

  float getDefense() {
    return defense;
  }

  float getAttack() {
    return attack;
  }

  float getRange() {
    return range;
  }

  float getWidth() {
    return w;
  }

  float getHeight() {
    return h;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  
  float getCenterX() {
    return centerX;
  }
  
  float getCenterY() {
    return centerY;
  }

  boolean attack(Unit u) {
    if (b == null) {
      b = new Bullet(centerX, centerY, u.x-centerX, u.y-centerY);
    }
    if (b.collision(u)) {
      if (attack - u.getDefense() > 0) {
        u.health -= attack - u.getDefense();
        b = null;
        //u.c = color(100,255,0);
        return true;
      }
    }
    if (b.getX()<312.5 || b.getX()>1087.5 || b.getY()<25 || b.getY()>height-25) {
      b = null;
    }    
    b.move();
    return false;
  }
  //how to display structures for now
  void display() {
    fill(c);
    rect(x, y, w, h);
    displayRange();
  }

  void displayRange() {
    fill(c, 50);
    ellipse(x+w/2, y+h/2, range, range);
  }
}