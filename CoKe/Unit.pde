abstract class Unit implements Location<Unit> {

  protected float health, defense, attack, speed, x, y, maxHealth;
  protected int state;

  float getHealth() {
    return health;
  }

  float getDefense() {
    return defense;
  }

  float getAttack() {
    return attack;
  }
  
  float getSpeed() {
    return speed;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }

  boolean attack(Unit u) {
    if (attack - u.getDefense() > 0) {
      u.health -=  attack - u.getDefense();
      return true;
    }
    return false;
  }
  
  boolean attack(Structure s){
    s.health = s.health - attack;
    return true;
  }
  
  abstract void attack();
  abstract void display();  
}