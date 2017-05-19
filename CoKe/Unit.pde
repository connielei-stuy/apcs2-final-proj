abstract class Unit {

  protected float health, defense, attack, speed, x, y, maxHealth;

  float getHealth() {
    return health;
  }

  float getDefense() {
    return defense;
  }

  float getAttack() {
    return attack;
  }

  boolean attack(Unit u) {
    if (attack - u.getDefense() > 0) {
      u.health -=  attack - u.getDefense();
      return true;
    }
    return false;
  }

//  boolean attack(Structure s){
    
  //}

  boolean heal() {
    float healing = random(maxHealth);
    if (health + healing < maxHealth) {
      health += healing;
      return true;
    }
    return false;
  }
  
  
  //void display();
  
}