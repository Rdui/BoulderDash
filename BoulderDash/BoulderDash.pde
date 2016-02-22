import g4p_controls.*;

// Gamestate is used to define the state of the game
// mainmenu, intro, game, gameover etc. 
interface State {
  byte WAIT_USER_INPUT = 0;
  byte STORY = 1;
  byte GAME= 2;
}


byte state = State.WAIT_USER_INPUT;

color backgroundColor = color(22);

Player player = new Player(0, 0);
PImage img;
PImage backgroundimage;
void setup() {
  background(backgroundColor);
  size(1280, 720);
  loadMap("map.txt", "chars.txt", "pickups.txt");
  mainMenuSetup();
  img = loadImage("graphics/tempModel.png");
  player.setCoordinates(startX*32, startY*32+8);
}

void printStory() {
  background(0);
  fill(0, 102, 153);
  textSize(14);
  textAlign(CENTER);
  text(playerName + " has fallen into a cave!", width/2, height/3);
  text("He has his smartphone with him and all necessary things to alert help", width/2, height/3+50);
  text("BUT, because " + playerName + " is such a manly man, he won't accept help from anyone!", width/2, height/3+70);
  text(playerName + " only has his boisterous biceps, his cutting edge brains and random tools found in the cave to aid him.", width/2, height/3+90);
  text("Good luck " + playerName + "!", width/2, height/3 + 120);
  textSize(20);
  text("Press any key to continue", width/2, height/3 + 150);
}

void storyEnd() {
  state = State.GAME;
}


// switch case structure to monitor state of the game
void draw() {
  background(backgroundColor);
  switch(state) {
  case State.WAIT_USER_INPUT:
    mainMenuDraw();
    break;
  case State.STORY:
    printStory();
    break;
  case State.GAME:

    drawBackground();
    drawMap();
    drawScore();

    //println(startX + " " + startY);
    player.move();
    player.drawPlayer();
    // Game starting function should be called here
    // players name: String playerName
    break;
  }
}

void drawScore() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(CENTER);
  text(player.score, width/2, 32);
}
// switch case structure to monitor state of the game
void keyTyped() {
  switch(state) {
  case State.WAIT_USER_INPUT:
    mainMenuKeyTyped();

    break;
  case State.STORY:
    storyEnd();
    break;
  case State.GAME:
    break;
  }
}

void keyPressed() {
  switch(state) {
  case State.WAIT_USER_INPUT:

    break;
  case State.STORY:
    break;
  case State.GAME:
    movementKeyPressed();
    break;
  }
}

void keyReleased() {
  switch(state) {
  case State.WAIT_USER_INPUT:

    break;
  case State.STORY:
    break;
  case State.GAME:
    movementKeyReleased();
    break;
  }
}

// switch case structure to monitor state of the game
void mousePressed() {
  switch(state) {
  case State.WAIT_USER_INPUT:
    // mainMenuKeyTyped();
    break;
  case State.GAME:

    break;
  }
}