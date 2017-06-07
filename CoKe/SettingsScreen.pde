class SettingsScreen extends Screen {

  SettingsScreen() {
    super();
    text("Important stuff you should know:\n-Press 'p' to pause the game\n-Press 't' to train a troop\n-You can only train troops if you have a barrack\n-You can only have one active barrack at one time\n-Click on a structure (other than walls) to upgrade it\n-You lose if your town hall is destroyed!" , 100,100);
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