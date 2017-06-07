class PauseScreen extends Screen {

  PauseScreen() {
    super();
    text("Important stuff you should know:\n-Press 'p' to pause the game\n-Press 't' to train a troop\n-You can only train troops if you have a barrack\n-You can only have one active barrack at one time\n-Click on a structure (other than walls) to upgrade it\n-You lose if your town hall is destroyed!" , 100,100);    
    buttons.add(new Button(width/2-200, height/2-25, 100, 50, color(255, 0, 0), "Quit?"));
  }

  void function(String command) {
    if (command == "Go Back") {
      currentScreen = previousScreen;
      previousScreen = Screens.PAUSE;
    }
    if (command == "Quit?") currentScreen = Screens.END;
  }
}