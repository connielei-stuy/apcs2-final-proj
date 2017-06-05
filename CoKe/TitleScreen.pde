class TitleScreen extends Screen {

  TitleScreen() {
    super();    
    background(0, 200, 255);
    textSize(64);
    text("CoKe\nA Game" , width/2-100, height/4);
    buttons.add(new Button(width/3-50, height/2-25, 100, 50, color(255, 0, 0), "Start game"));
    buttons.add(new Button(2*(width/3)-50, height/2-25, 100, 50, color(255, 0, 0), "Settings"));
  }

  void function(String command) {
    if (command == "Go Back") text("Can't go back!",200,200);    
    if (command == "Start game") startGame = true;
    if (command == "Settings") {
      currentScreen = Screens.SETTINGS;
      previousScreen = Screens.TITLE;
    }
  }
}