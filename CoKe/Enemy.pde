class Enemy extends Unit {

  LLStack<Enemy> temp;
  
  Enemy() {
    enemySpawn();
    enemyAdjust();
    setEnemy();
    defaults();
    heaping();
  }

  Enemy(float maxHealth, float attack, float speed, float gold, PImage north, PImage east, PImage south, PImage west) {
    _health = maxHealth;
    _maxHealth = maxHealth;
    _attack = attack;
    _speed = speed;
    _gold = gold;
    _north = north;
    _east = east;
    _south = south;
    _west = west;
  }

  void enemySpawn(){
    temp = new LLStack<Enemy>();
    temp.push(new Enemy(500, 50, 3.5, 120, loadImage("eee_n.png"), loadImage("eee_e.png"), loadImage("eee_s.png"), loadImage("eee_w.png")));
    temp.push(new Enemy(250, 40, 2.5, 80, loadImage("ee_n.png"), loadImage("ee_e.png"), loadImage("ee_s.png"), loadImage("ee_w.png")));
    temp.push(new Enemy(150, 30, 2, 50, loadImage("e_n.png"), loadImage("e_e.png"), loadImage("e_s.png"), loadImage("e_w.png")));
  }

  void enemyAdjust(){
    if(difficulty == 3 && random(10) > 7 )
      temp.pop();
  }
  
  void setEnemy(){
    Enemy copy = temp.pop();
    _maxHealth = copy.getMaxHealth();
    _attack = copy.getAttack();
    _speed = copy.getSpeed();
    _gold = copy.getGold();
    _north = copy.getNorth();
    _east = copy.getEast();
    _south = copy.getSouth();
    _west = copy.getWest();
  }
  
  void defaults() {
    _state = 0;
    _width = 20;
    _height  = 20;
    _health = _maxHealth;
    photo = _west;
    coordinates();
  }
  
  void coordinates(){
     float r = random(100);
    if (r >= 0 && r <25) {
      _x = random(300, width-300);
      _y = 25;
    } else if (r >= 25 && r <50) {
      _x = width-300;
      _y = random(25, height-25);
    } else if (r >= 50 && r<75) {
      _x = random(300, width-300);
      _y = height-25;
    } else {
      _x = 300;
      _y = random(25, height-25);
    } 
    _centerX = _x;
    _centerY = _y;
  }

  void heaping() {
    targets = new ALHeap<Entity>(_x, _y);
    for (Structure st : structures)
      targets.add(st);
    for (Troop tr : troops)
      targets.add(tr);
  }

  void move() {
    //goes through its targets to check if target is still alive
    while (!targets.isEmpty() && targets.peekMin().getHealth() <= 0)
      targets.removeMin();

    //checks if target exists
    if (!targets.isEmpty()) {
      Entity temp = targets.peekMin();

      float _dx = 0, _dy = 0, dis = 0;

      //NORTH OR SOUTH
      if (temp.getCX() - temp.getWidth()/2 <= _x && _x <= temp.getCX() + temp.getWidth()/2) {
        _dx = 0;
        _dy = _speed * (temp.getCY() - _y) / abs(temp.getCY() - _y);
        dis = abs(temp.getCY() - _y) - temp.getHeight()/2;
        if (dis - 10 < _speed) {
          _dy = dis - 10;
          _state = 1;
        }

        //updates display photo
        if (temp.getCY() - _y > 0)
          photo = _south;
        else
          photo = _north;
      }

      //EAST OR WEST
      else if (temp.getCY() - temp.getHeight() /2 < _y && _y <= temp.getCY() + temp.getHeight()/2) {
        _dy = 0;
        _dx = _speed * (temp.getCX() - _x)/ abs(temp.getCX() - _x);
        dis = abs(temp.getCX() - _x) - temp.getWidth()/2;
        if (dis - 10 < _speed) {
          _dx = dis - 10;
          _state = 1;
        }

        //updates display photo
        if (temp.getCX() - _x > 0)
          photo = _east;
        else
          photo = _west;
      }

      //DIAGONAL
      else {
        float topY = temp.getCY() - temp.getHeight()/2;
        float botY = temp.getCY() + temp.getHeight()/2;
        float rightX = temp.getCX() - temp.getWidth()/2;
        float leftX = temp.getCX() + temp.getWidth()/2;

        float quadI = dist(_x, _y, rightX, topY);
        float quadII = dist(_x, _y, leftX, topY);
        float quadIII = dist(_x, _y, leftX, botY);
        float quadIV = dist(_x, _y, rightX, botY);
        float[] values = {quadI, quadII, quadIII, quadIV};

        float cornerX = rightX;
        float cornerY = botY;

        //SOUTH EAST
        if (min(values) == quadI) {
          cornerY = topY;

          //updates display photo
          photo = _south;
          if (random(10) > 5)
            photo = _east;
        } 
        
        //SOUTH WEST
        else if (min(values) == quadII) {
          cornerX = leftX;
          cornerY = topY;

          //updates display photo
          photo = _south;
          if (random(10) > 5)
            photo = _west;
        } 
        
        //NORTH WEST
        else if (min(values) == quadIII) {
          cornerX = leftX;

          photo = _north;
          if (random(10) > 5)
            photo = _west;
        } 
        
        //NORTH EAST
        else {
          photo = _north;
          if (random(10) > 5) 
            photo = _east;
        }

        dis = dist(cornerX, cornerY, _x, _y);

        float tempSpeed = _speed;

        if (dis - 10 < _speed) {
          tempSpeed = dis - 10;
          _state = 1;
        }
        float hyp = dist(cornerX, cornerY, _x, _y);
        _dx = tempSpeed * (cornerX - _x) / hyp;
        _dy = tempSpeed * (cornerY - _y) / hyp;
      }

      _x += _dx; 
      _y += _dy; 
      
      _centerX = _x;
      _centerY = _y;
    }
  }

  void add(Entity e) {
    targets.add(e);
  }
}