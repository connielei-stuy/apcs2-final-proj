class Button {
  
  boolean overButton;
  boolean buttonPressed;
  String buttonMessage;
  float _x, _y, _width , _height;
  color c;
  
  Button(float x , float y , float w , float h , color col , String bMes) {
    _x = x;
    _y = y;
    _width = w;
    _height = h;
    c = col;
    buttonMessage = bMes;
  }
  
  boolean overButton() {
    if (mouseX > _x && mouseX < _x+_width &&
        mouseY > _y && mouseY < _y+_height )
          return true;
    return false;
  }
  
  void display() {
    fill(c);
    rect(_x,_y,_width,_height);
    fill(255);
    textSize(18);
    text(buttonMessage,_x+3,_y+_height/2);
  }
}