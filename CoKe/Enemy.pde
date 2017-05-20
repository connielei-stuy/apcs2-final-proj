class Enemy extends Unit{
  
  Enemy(){
    health = 50;
    defense = random(50);
    attack = random(50);
    speed = random(10);
    x = height;
    y = width;
  }
  
  void display(){
    fill(color(14, 15, 15));
    ellipse(x, y, 300,150);
  }
  
  void update(){
    if(state == 0){
      move();
    }
    else if (state == 1){
      attack(s); //where s is structure
    }
  }
  
  void move(){
    
    
  }
  
}