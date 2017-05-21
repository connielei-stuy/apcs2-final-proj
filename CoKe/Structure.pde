class Structure implements Location<Structure> {

  protected float health, defense, attack, range, w, h, x, y , centerX, centerY;
  protected color c;
  protected Bullet b = null;

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

  boolean attack(Unit u) {
    if (attack - u.getDefense() > 0) {
      u.health -= attack - u.getDefense();
      return true;
    }
    return false;
  }
  
  boolean attack(Structure u) {
    if (b == null) {
      b = new Bullet(centerX,centerY,u.centerX-centerX,u.centerY-centerY);
    }
    if (collision(b,u)) {
      if (attack - u.getDefense() > 0) {
        u.health -= attack - u.getDefense();
        //u.c = color(0);
        return true;
      }
    }
    else b.move();
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