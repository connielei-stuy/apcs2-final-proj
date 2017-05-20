class Structure implements Location<Structure>{
  
  protected float health, defense, attack, w, h, x, y;
  protected color c;
  
  float getHealth() {
    return health;
  }

  float getDefense() {
    return defense;
  }

  float getAttack() {
    return attack;
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
  
  //how to display structures for now
  void display(){
    fill(c);
    rect(x,y,w,h);
  }
  
}
  