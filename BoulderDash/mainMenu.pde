// This file defines main menu functionality

String playerName = "";
GButton newGameButton;
GButton levelSelectButton;
GButton quitButton;
GButton startButton;
GEvent buttonEvent;

GButton[] levelButtons;

// initialize main menu buttons
void mainMenuSetup() {
  newGameButton = new GButton(this, width/2.9, height/4, 400, 50, "Start new game");
  levelSelectButton = new GButton(this, width/2.9, height/3, 400, 50, "Select a level");
  quitButton = new GButton(this, width/2.9, height/2.4, 400, 50, "Exit");
}

// initialize new game screen buttons
void newGameSetup() {
  startButton = new GButton(this, width/2.9, height/2, 400, 50, "Star new game");
}

void levelSelectSetup() {
  levelButtons = new GButton[mapCount];
  for (int i = 0; i < mapCount; i++) {
    levelButtons[i] = new GButton(this, width/(64.0/9.0)+(i%3)*310, height/15+(i/3)*60, 300, 50, "Level "+(i+1));
  }
}

void nameSelectDraw() {
  // "Type player name"
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Type player name:", width/2, height/3);
  //textfield box
  fill(204, 153, 51);
  rectMode(CENTER);
  rect(width/2, height/2.5, 400, 50, 25, 5, 25, 5);
  // text itself
  fill(22);
  text(playerName, width/2, height/2.45);
}

// controlling name input text
void mainMenuKeyTyped() {
  if (key == '\b') {
    if (playerName.length() >= 1) {
      playerName = playerName.substring(0, playerName.length() - 1);
    }
  } else {
    if (key != '\n') {
      playerName += key;
    }
    if (key == '\n') {
      String playerNametemp = playerName.replaceAll("\\s+", "");
      if (playerNametemp.length() != 0) {
        startButton.dispose();
        loadMap("Maps/map"+mapNumber+".txt", "chars.txt");
        state = State.STORY;
      }
    }
  }
}

// Handling button event
void handleButtonEvents(GButton button, GEvent event) {
  if (button == startButton && event == GEvent.CLICKED) {
    String playerNametemp = playerName.replaceAll("\\s+", "");
    if (playerNametemp.length() != 0) {
      button.dispose();
      loadMap("Maps/map"+mapNumber+".txt", "chars.txt");
      state = State.STORY;
    }
  }
  if (button == levelSelectButton && event == GEvent.CLICKED) { // switch to level selection view
    disposeMainButtons();
    levelSelectSetup();
    state = State.SELECT_LEVEL;
  }
  if (button == newGameButton && event == GEvent.CLICKED) { // switch to player name prompt
    disposeMainButtons();
    newGameSetup();
    state = State.NAME_INPUT;
  }
  if (button == retryButton && event == GEvent.CLICKED) {
    clearMap();
    resetKeyboardInputs();
    deleteHighscoreButtons();
      loadMap("Maps/map"+mapNumber+".txt", "chars.txt");
      state = State.GAME;
  }
  if (button == exitButton || button == quitButton && event == GEvent.CLICKED) {
    exit();
  }
  if (state == State.SELECT_LEVEL && button.getText().split(" ")[0].equals("Level"))
  {
    mapNumber = int(button.getText().split(" ")[1])-1;
    for (GButton levelButton : levelButtons)
      levelButton.dispose();
    newGameSetup();
    state = State.NAME_INPUT;
  }
}

// get rid of main menu buttons
void disposeMainButtons() {
  newGameButton.setVisible(false);
  levelSelectButton.setVisible(false);
  quitButton.setVisible(false);
  newGameButton.dispose();
  levelSelectButton.dispose();
  quitButton.dispose();
  newGameButton = null;
  levelSelectButton = null;
  quitButton = null;
}