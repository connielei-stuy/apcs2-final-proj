class Structure extends Entity {

  protected float _centerX, _centerY;
  protected color c;
  protected Bullet b = null;
  int sec = second();

  float getCenterX() {
    return _centerX;
  }

  float getCenterY() {
    return _centerY;
  }

  boolean attack(Entity e) {
    if (b == null)
      b = new Bullet(_centerX, _centerY, e.getX() - _centerX, e.getY() - _centerY);
    if (b.collision(e)) {
      e.takeDamage(_attack);
      b = null;
      //u.c = color(100,255,0);
      return true;
    }
    b.move();
    if (b.getX() < 312.5 || b.getX() > 1087.5 || b.getY() < 25 || b.getY() > height - 25)
      b = null; 

    return false;
  }

  //how to display structures for now
  void display() {
    fill(c);
    rect(_x, _y, _width, _height);
    displayRange();
  }

  void displayRange() {
    fill(c, 50);
    ellipse(_x + _width/2, _y + _height/2, _range, _range);
  }
}