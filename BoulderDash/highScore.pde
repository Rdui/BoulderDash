
void highscoreSetup(){
  newGameButton = new GButton(this, 300, 600, 300, 50, "New Game!");
  exitButton = new GButton(this, 690, 600, 300, 50, "Exit to desktop");
  
}

void deleteHighscoreButtons(){
  newGameButton.dispose();
  exitButton.dispose();
}