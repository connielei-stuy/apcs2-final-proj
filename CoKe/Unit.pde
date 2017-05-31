abstract class Unit extends Entity {

  protected float _speed, maxHealth,_gold;
  protected color c;
  protected int state;

  float getSpeed() {
    return _speed;
  }

  void attack(Entity e) {
    e.takeDamage(_attack);
  }
  
  
  abstract void update();
  abstract void attack();
  abstract void display();  
}