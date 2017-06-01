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

  abstract void attack();
  abstract void move();
  abstract void display();
}