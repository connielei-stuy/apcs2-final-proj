abstract class Unit extends Entity {

  protected float _speed, _gold;
  protected color c;
  protected int state;
  protected ALHeap<Entity> targets;
  int sec = second();
  float _dx,_dy;

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
/*
  void attack() {
    int tempSec = second();
    if (tempSec -sec > 2) {
      sec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        state = 0;
      }
    }
  }*/
  
  abstract void attack();

  abstract void move();
  abstract void display();
}