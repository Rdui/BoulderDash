// This file defines mainmenu functionality


String playerName = "";
GButton startButton;
GButton quitButton;
GEvent buttonEvent;

void mainMenuSetup() {
  startButton = new GButton(this, width/2.9, height/2.2, 400, 50, "Aloita peli!");
}


void mainMenuDraw() {

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
      state = State.STORY;
    }
  }
}