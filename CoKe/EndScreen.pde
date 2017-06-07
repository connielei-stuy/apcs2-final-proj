class EndScreen extends Screen {

  EndScreen() {
    background(0);
    fill(255, 0, 0);
    textSize(24);
    text("Number of enemies defended against: " + numKilled , width/2-175 , height/2+150);
    textSize(64);
    text("GAME OVER", width/2-175, height/2);
  }
  
    
}