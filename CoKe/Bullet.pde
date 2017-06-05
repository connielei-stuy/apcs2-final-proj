class Bullet implements Location<Bullet>{

  float speed, w, h, x, y, dx, dy;
  PImage photo;
  
  Bullet(float startX , float startY , float moveX , float moveY) {
    w = 10;
    h = 10;
    x = startX;
    y = startY;
    dx = moveX;
    dy = moveY;
    photo = loadImage("bullet.png");
  }
  
  void move() {
    
    image(photo, x - w, y - h, w , h);
    x += dx/20;
    y += dy/20;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  boolean collision(Entity u) {
    return dist(x, y, u.getX(), u.getY()) < (w);
  }
  
}