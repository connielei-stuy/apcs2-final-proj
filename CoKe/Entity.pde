abstract class Entity implements Location<Entity>{
  
  protected float _health, _defense, _attack, _x, _y, _centerX, _centerY, _width, _height, _range;
  
  float getX(){
    return _x;
  }
  
  float getY(){
    return _y;
  }
  
  float getCX(){
    return _centerX;
  }
  
  float getCY(){
   return _centerY;
  }
  float getHealth(){
    return _health;
  }
  
  float getDefense(){
    return _defense;
  }
  
  float getAttack(){
    return _attack;
  }
  
  float getWidth(){
   return _width; 
  }
  
  float getHeight(){
    return _height;
  }
  
  float getRange(){
    return _range;
  }
  
  void setHealth(float newHealth){
    _health = newHealth;
  }
  
  void takeDamage(float attack){
    if(attack - _defense > 0)
      setHealth(_health - (attack - _defense));
  }
  
  abstract void display();
  
}