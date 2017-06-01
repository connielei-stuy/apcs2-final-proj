class Structure extends Entity {

  protected String ID;
  protected color c;
  protected Bullet b = null;

  String getID() {
    return ID;
  }

  void attack(Entity e) {
    if (b == null)
      b = new Bullet(_centerX, _centerY, e.getX() - _centerX, e.getY() - _centerY);
    if (b.collision(e)) {
      e.takeDamage(_attack);
      b = null;
      //u.c = color(100,255,0);
    }
    b.move();
    if (b.getX() < 312.5 || b.getX() > 1087.5 || b.getY() < 25 || b.getY() > height - 25)
      b = null; 
  }

  //checks if this is a certain structure
  boolean isA(String str) {
    if (this.getID() == str) {
      return true;
    }
    return false;
  }

  //rotates
  void rotate() {
    float w = _width;
    _width = _height;
    _height = w;
  }

  //how to display structures for now
  void display() {
    fill(c);
    rect(_x, _y, _width, _height);
    fill(c, 50);
    ellipse(_x + _width/2, _y + _height/2, _range, _range);
  }

  void update() {
    display();
    for (Enemy e : enemies) {
      if (inRange(e))
        attack(e);
        return;
    }
  }

  boolean inRange(Entity target) {
    float distance = dist(_centerX, _centerY, target.getX(), target.getY());
    return (distance < _range/2 && distance != 0);
  }
}