class Barrack extends Structure {

  ArrayPriorityQueue<Troop> trainingQ;
  LLStack<Barrack> temp;

  Barrack() {
    spawnBarrack();
    setBarrack();
    defaults();
  }

  Barrack(float maxHealth, float time, float gold, PImage barrack) {
    _maxHealth = maxHealth;
    _time = time;
    _gold = gold;
    photo = barrack;
  }

  void spawnBarrack() {
    temp = new LLStack<Barrack>();
    temp.push(new Barrack(10000, 10, 1400, loadImage("barrack9.png")));
    temp.push(new Barrack(10000, 9, 1100, loadImage("barrack7.png")));
    temp.push(new Barrack(10000, 8, 800, loadImage("barrack5.png")));
    temp.push(new Barrack(15000, 7, 500, loadImage("barrack2.png")));
    temp.push(new Barrack(10000, 6, 300, loadImage("barrack.png")));
    adjustBarrack();
  }
  
  void adjustBarrack(){
    if(difficulty == 0 || (difficulty == 1 && random(10) > 5))
      temp.pop();
  }

  void setBarrack(){
    Barrack copy = temp.pop();
    _maxHealth = copy.getHealth();
    _time = copy.getTime();
    _gold = copy.getGold();
    photo = copy.getPhoto();
  }

  void defaults() {
    ID = "barrack";
    _health = _maxHealth; 
    _attack = 0;
    _range = 0;
    _width = 60;
    _height = 60;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
  }
  
  //trains a troop by adding it to the training queue, later removed and added to arraylist
  void train() {
    trainingQ.add(new Troop());
  }
  
}