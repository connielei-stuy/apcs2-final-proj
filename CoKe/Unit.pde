abstract class Unit extends Entity {

  protected float _speed;

  protected int _state;
  protected ALHeap<Entity> targets;
  int sec = second();
  float _dx,_dy;

  protected PImage _north, _east, _south, _west;
  
  float getSpeed() {
    return _speed;
  }

  void attack(Entity e) {
    e.takeDamage(_attack);
  }

  void update() { 
    if (_state == 1)
      attack();
    else
      move();
    display();
  }
  
  PImage getNorth(){
     return _north; 
  }
  
  PImage getSouth(){
     return _south; 
  }
  
  PImage getEast(){
    return _east;
  }
  
  PImage getWest(){
     return _west; 
  }

  void attack() {
    int tempSec = second();
    if (tempSec -sec > 2) {
      sec = second();
      attack(targets.peekMin());
      if (targets.peekMin().getHealth() < 0) {
        targets.removeMin();
        _state = 0;
      }
    }
  }
  
  abstract void move();
}