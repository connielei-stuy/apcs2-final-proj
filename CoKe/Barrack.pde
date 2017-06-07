class Barrack extends Structure {

  ArrayPriorityQueue<Troop> trainingQ;
  LLStack<Barrack> temp;
  int p;

  Barrack() {
    if(difficulty == 0 || (difficulty == 1 && random(10) > 5)){
      setBarrack(BARRACKUPGRADES.get(1));
      _level = 1;
    }
    else {
      setBarrack(BARRACKUPGRADES.get(0));
      _level = 0;
    }
    defaults();
  }

  Barrack(float maxHealth, float time, float gold, PImage barrack) {
    _maxHealth = maxHealth;
    _time = time;
    _gold = gold;
    photo = barrack;
  }
  
  void setBarrack(Barrack copy){
    _maxHealth = copy.getMaxHealth();
    _health = _maxHealth; 
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
    p = 1;
    trainingQ = new ArrayPriorityQueue<Troop>();
  }
  
  //trains a troop by adding it to the training queue, later removed and added to arraylist
  void addTroop(Troop other){
    if(other.getInQueue()){
      other.setPriority(p);
      p ++;
    }
    else{
      trainingQ.add(other);
      other.setInQueue(true);
    }
  }
  
  void trainTroop(){
    if(!trainingQ.isEmpty()){
    int _sec = second();
    trainingQ.peekMin().time(abs(trainSec - (_sec + 60)) % 3);
    if(trainingQ.peekMin().getTime() <= 0)
      trainingQ.removeMin().upgrade();
      trainSec = second();
    }
  }
  
  void upgrade(){
    if(_time <= 0){
      setBarrack(BARRACKUPGRADES.get(_level + 1));
      _level ++;
      inQueue = false;
    }
  }
  
  boolean emptyTrainingQueue(){
    return trainingQ.isEmpty();
  }
  
  boolean maxedOut(){
    return _level >= BARRACKUPGRADES.size() - 1;
  }
}