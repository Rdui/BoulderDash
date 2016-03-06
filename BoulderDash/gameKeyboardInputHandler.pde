float up = 0;
float down = 0;
float left = 0;
float right = 0;
float rotateleft = 0;
float rotateright = 0;
int changedItem = 0;

void movementKeyPressed() {
  if (key == 'w' || key == 'W') {
    up = 1;
  } else if (key == 's' || key == 'S') {
    down = 1;
  } else if (key == 'a' || key == 'A') {
    left = 1;
  } else if (key == 'd' || key == 'D') {
    right = 1;
  } else if (key == 'q' || key == 'Q') {
    rotateleft = 1;
  } else if (key == 'e' || key == 'E') {
    rotateright = 1;
  }
}

void movementKeyReleased() {
  if (key == 'w' || key == 'W') {
    up = 0;
  } else if (key == 's' || key == 'S') {
    down = 0;
  } else if (key == 'a' || key == 'A') {
    left = 0;
  } else if (key == 'd' || key == 'D') {
    right = 0;
  } else if (key == 'q' || key == 'Q') {
    rotateleft = 0;
    changedItem = 0;
  } else if (key == 'e' || key == 'E') {
    rotateright = 0;
    changedItem = 0;
  }
}

void bombKeyPressed(){
  
  if(key == ' '){
    println("space");
    Bomb bomb = new Bomb(1);
    player.drop_bomb(bomb);
    
    
  }
  
}