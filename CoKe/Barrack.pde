class Barrack extends Structure{
  
  ArrayPriorityQueue<Troop> trainingQ;
  
  Barrack(){
    ID = "barrack";
    _health = 500;
    _defense = 50;
    _attack = 0;
    _range = 0;
    _width = 60;
    _height = 60;
    _x = mouseX - _width/2;
    _y = mouseY - _height/2;
    _centerX = _x + _width/2;
    _centerY = _y + _height/2;
    c = color(100, 50, 200);
    cost = 300;
    trainingQ = new ArrayPriorityQueue<Troop>();
  }
  
  //trains a troop
  void train() {
    trainingQ.add(new Troop());
  }
  
  
  
  
}