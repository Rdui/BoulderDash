GButton retryButton;
GButton exitButton;

void highscoreSetup(){
  retryButton = new GButton(this, 300, 600, 300, 50, "Retry!");
  exitButton = new GButton(this, 690, 600, 300, 50, "Give up");
}

void deleteHighscoreButtons(){
  retryButton.dispose();
  exitButton.dispose();
}