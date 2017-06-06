class PauseScreen extends Screen {

  PauseScreen() {
    super();
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