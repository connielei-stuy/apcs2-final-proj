class SettingsScreen extends Screen {

  SettingsScreen() {
    super();
    buttons.add(new Button(width/2-200, height/2-25, 100, 50, color(255, 0, 0), "Easy"));
    buttons.add(new Button(width/2-50, height/2-25, 100, 50, color(255, 0, 0), "Medium")); 
    buttons.add(new Button(width/2+100, height/2-25, 100, 50, color(255, 0, 0), "Hard"));
  }

  void function(String command) {
    if (command == "Go Back"){
      currentScreen = previousScreen;
      previousScreen = Screens.SETTINGS;
    }
    if (command == "Easy") difficulty = 0;
    if (command == "Medium") difficulty = 1;
    if (command == "Hard") difficulty = 2;
  }
}