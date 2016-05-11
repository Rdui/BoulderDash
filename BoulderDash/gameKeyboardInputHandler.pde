float up = 0;
float down = 0;
float left = 0;
float right = 0;

void movementKeyPressed() {
  if (key == 'w' || key == 'W') {
    up = 1;
    player.icon = playerIconUp;
  } else if (key == 's' || key == 'S') {
    down = 1;
    player.icon = playerIconDown;
  } else if (key == 'a' || key == 'A') {
    left = 1;
    player.icon = playerIconLeft;
  } else if (key == 'd' || key == 'D') {
    right = 1;
    player.icon = playerIconRight;
  }
}

void movementKeyReleased() {
  // player movement
  if (key == 'w' || key == 'W') {
    up = 0;
  } else if (key == 's' || key == 'S') {
    down = 0;
  } else if (key == 'a' || key == 'A') {
    left = 0;
  } else if (key == 'd' || key == 'D') {
    right = 0;
  }
  // inventory
  else if (key == 'q' || key == 'Q') {
    if (player.selectedItem -1 >= 0)
      player.selectedItem--;
  } else if (key == 'e' || key == 'E') {
    if (player.selectedItem +1 < player.inventory.size())
      player.selectedItem++;
  }
}

void resetKeyboardInputs() {
  up = 0;
  down = 0;
  left = 0;
  right = 0;
}

void useKeyPressed() {
  if (key == ' ' && player.selectedItem > -1) {
    player.inventory.get(player.selectedItem).Use(player.inventory.get(player.selectedItem));
  }
}

void pauseKeyPressed() {
  if (key == 'p' || key ==  'P') {
    if (state == State.GAME){
      state = State.PAUSE;
    }
    else{
      state = State.GAME;
    }
  }
}