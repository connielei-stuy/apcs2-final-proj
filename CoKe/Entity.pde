abstract class Entity implements Location<Entity>{
  
  protected float _health, _attack, _x, _y, _centerX, _centerY, _width, _height, _range;
  
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
      setHealth(_health - attack);
  }
  
  abstract void display();
  
}