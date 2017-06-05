class SettingsScreen extends Screen{
  
  SettingsScreen() {
    super();
    background(0, 200, 255);
    buttons.add(new Button(width/3-50,height/2-25,100,50,color(255,0,0),"+ Difficulty"));
    buttons.add(new Button(2*(width/3)-50,height/2-25,100,50,color(255,0,0),"- Difficulty")); 
  }
  
  void function(String command) {
    if (command == "Go Back") currentScreen = previousScreen;
    if (command == "+ Difficulty") difficulty = difficulty + 1;
    if (command == "- Difficulty") difficulty = difficulty - 1;
  }
  
}
    