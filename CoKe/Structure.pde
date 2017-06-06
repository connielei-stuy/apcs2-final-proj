class Structure extends Entity {

  protected String ID;
  protected float _time;
  protected Bullet b = null;
  int sec = second();

  String getID() {
    return ID;
  }

  float getTime(){
     return _time; 
  }

  //generate a bullet and make the bullet move to an enemy
  void attack(Entity e) {
    if (b == null) //if there isn't already an active bullet
      b = new Bullet(_centerX, _centerY, e.getX() - _centerX, e.getY() - _centerY); //make a new bullet
    if (b.collision(e)) { //if bullet and enemy collides
      e.takeDamage(_attack); //enemy takes damage
      b = null; //bullet dies
      return;
    }
    b.move(); //bullet moves
    if (b.getX() < 312.5 || b.getX() > 1087.5 || b.getY() < 25 || b.getY() > height - 25) //outta bounds
      b = null;
  }

  //checks if "this" is a certain structure by comparing ID's
  boolean isA(String str) {
    if (this.getID() == str) {
      return true;
    }
    return false;
  }

  //rotates a structure by swapping width and height
  void rotate() {
    float w = _width;
    _width = _height;
    _height = w;
  }

  //executes structure's functions
  void update() {
    if(photo == null){
      System.out.println("photo is missing");
    }
    display();
    for (Enemy e : enemies) {
      if (inRange(e)) {
        attack(e);
        return;
      }
    }
  }


//checks if an entity is in-range for a structure to attack
//true if in-range, false if not in-range
  boolean inRange(Entity target) {
    float distance = dist(_centerX, _centerY, target.getX(), target.getY());
    return (distance < _range/2 && distance != 0);
  }
}