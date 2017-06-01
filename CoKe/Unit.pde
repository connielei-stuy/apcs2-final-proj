abstract class Unit extends Entity {

  protected float _speed, maxHealth, _gold;
  protected color c;
  protected int state;
  protected ALHeap<Entity> targets;

  float getSpeed() {
    return _speed;
  }

  void attack(Entity e) {
    e.takeDamage(_attack);
  }

  void update() {  
    display();
    if (state == 1)
      attack();
    else
      move();
  }

  void attack() {
    int tempSec = second();
    if (tempSec % 2 == 0) {
      enemySec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }

  abstract void move();
  abstract void display();
}