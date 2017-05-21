class Bullet {

  float speed, w, h, x, y, dx, dy;
  
  Bullet(float startX , float startY , float moveX , float moveY) {
    w = 15;
    h = 15;
    x = startX;
    y = startY;
    dx = moveX;
    dy = moveY;
  }
  
  void move() {
    fill(150,150,0);
    ellipse(x , y , w , h);
    x += dx/33;
    y += dy/33;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  boolean collision(Structure s) {
    return dist(x, y, s.getX(), s.getY()) < (w + s.getWidth());
  }
  
}