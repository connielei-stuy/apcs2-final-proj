abstract class Structure extends Entity implements Comparable<Structure>{

  protected float _time;
  protected int _level;
  protected float _priority;
  protected Bullet b = null;
  protected boolean inQueue;
  int sec = second();

  float getTime(){
     return _time; 
  }
  
  int getLevel(){
    return _level; 
  }
  
  void train(){
    inQueue = true;
  }
  
  boolean getInQueue(){
    return inQueue;
  }
  
  void setInQueue(boolean x){
    inQueue = x;
  }
  
  void setPriority(float priority){
    _priority = priority;
  }
  
  float compareTo(Structure other){
     return _priority - other.getPriority();
  }
  
  float getPriority(){
    return _priority;
  }
  
  void time(float time){
    _time -= time;
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
    return(ID == str);
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
  
  abstract void upgrade();
  abstract boolean maxedOut();
  
    String toString(){
    return "" + ID + _priority;
  }
}