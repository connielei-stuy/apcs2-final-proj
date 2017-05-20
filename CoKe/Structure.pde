abstract class Structure {
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
    return width;
  }
  
  float getHeight() {
    return height;
  }
  
  boolean attack(Unit u) {
    if (attack - u.getDefense() > 0) {
      u.health -= attack - u.getDefense();
      return true;
    }
    return false;
  }
  
  void display(){
  }
  
}
  