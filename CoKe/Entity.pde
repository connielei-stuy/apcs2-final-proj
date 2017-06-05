abstract class Entity implements Location<Entity>{
  
  protected float _health, _attack, _x, _y, _centerX, _centerY, _width, _height, _range, _gold;
  protected PImage photo;
  
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
  
  float getGold() {
    return _gold;
  }
  
  void setHealth(float newHealth){
    _health = newHealth;
  }
  
  void takeDamage(float attack){
      setHealth(_health - attack);
  }
  
  void display(){
    image(photo, _centerX - _width/2, _centerY - _height/2, _width * 1.2, _height * 1.2);
  }
  
  abstract void update();
  
}