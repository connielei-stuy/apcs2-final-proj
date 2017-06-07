abstract class Entity implements Location<Entity>{
  
  protected float _health, _maxHealth, _attack, _x, _y, _centerX, _centerY, _width, _height, _range, _gold;
  protected PImage photo;
  protected String ID;
  
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
  
  float getMaxHealth(){
     return _maxHealth; 
  }
  
  PImage getPhoto(){
   return photo; 
  }
  
  String getID() {
    return ID;
  }
  
  void setHealth(float newHealth){
    _health = newHealth;
  }
  
  void takeDamage(float attack){
      setHealth(_health - attack);
  }
  
  void display(){
    image(photo, _centerX - _width/2, _centerY - _height/2, _width, _height);
  }
  
  void healthBar() {
    if (_health >= 0) {
      fill(255, 0, 0);
      rect(_centerX - _width/2, _centerY - _height/2 - 10, _width, 5);

      // Bar
      float drawWidth = (_health/ _maxHealth) * _width;
      fill(0, 255, 0); // Green
      rect(_centerX - _width/2, _centerY - _height/2 - 10, drawWidth, 5);
    }
  } 
  
  abstract void update();
  
}