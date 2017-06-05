abstract class Screen {

  ArrayList<Button> buttons = new ArrayList<Button>();
  
  Screen() {
    buttons.add(new Button(100,height-300,100,50,color(255,0,0),"Go Back"));
  }

  void draw() {
    for (Button b : buttons) {
      b.display();
    }
  }
  
  void function(String command){
  }
}