class TownHall extends Structure {

  LLStack<TownHall> temp;

  TownHall() {
    townHallSpawn();
    adjustTownHall();
    setTownHall();
    defaults();
    if(photo != null){
       System.out.println("town hall pictures works"); 
    }
  }

  TownHall(float maxHealth, float attack, float range, float time, float gold, PImage townhall) {
    _maxHealth = maxHealth;
    _attack = attack;
    _range = range;
    _gold = gold;
    _time = time;
    photo = townhall;
  }

  void townHallSpawn() {
    temp = new LLStack<TownHall>();
    temp.push(new TownHall(100000, 30, 185, 5, -1, loadImage("townhall10.png")));
    temp.push(new TownHall(77000, 22, 177, 6, 2000, loadImage("townhall9.png")));
    temp.push(new TownHall(35000, 18, 173, 7, 1700, loadImage("townhall8.png")));
    temp.push(new TownHall(28000, 15, 170, 8, 1450, loadImage("townhall7.png")));
    temp.push(new TownHall(25000, 13, 168, 9, 1300, loadImage("townhall6.png")));
    temp.push(new TownHall(18000, 10, 165, 10, 950, loadImage("townhall5.png")));
    temp.push(new TownHall(15000, 9, 164, 11, 850, loadImage("townhall4.png")));
    temp.push(new TownHall(10000, 8, 163, 12, 750, loadImage("townhall3.png")));
  }

  void adjustTownHall() {
    if (difficulty > 0) {
      temp.push(new TownHall(8000, 7, 162, 13, 500, loadImage("townhall2.png")));
      if (difficulty == 2 || (random(10) > 5)) {
        temp.push(new TownHall(5000, 6, 161, 14, 300, loadImage("townhall1.png")));
        if (difficulty == 2 || (random(10) > 5))
          temp.push(new TownHall(1000, 5, 160, 15, 100, loadImage("townhall.png")));
      }
    }
  }

  void setTownHall() {
    TownHall copy = temp.pop();
    _maxHealth = copy.getMaxHealth();
    _attack = copy.getAttack();
    _gold = copy.getGold();
    photo = copy.getPhoto();
  }

  void defaults() {
    ID = "townhall";
    _width = 80;
    _height = 80;
    _health = _maxHealth;
    _x = 1400/2 - _width/2;
    _y = 825/2 - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _width/2;
  }
}