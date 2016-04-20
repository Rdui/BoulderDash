import g4p_controls.*;
import java.io.File;

// Gamestate is used to define the state of the game
// mainmenu, intro, game, gameover etc. 
interface State {
  byte WAIT_USER_INPUT = 0;
  byte STORY = 1;
  byte GAME= 2;
  byte END = 3;
  byte PAUSE = 4;
}


byte state = State.WAIT_USER_INPUT;

color backgroundColor = color(22);

Player player;

PImage img;
PImage selector;
PImage bomb_1_img;
PImage bomb_2_img;
PImage exp_hori_img;
PImage exp_vert_img;
PImage exp_middle_img;
PImage backgroundimage;
String[] scores;
// normal bomb
Bomb basicBomb;


int time = 500, mapCount = 0;



void setup() {
  basicBomb = new Bomb(loadImage("graphics/smallbomb.png"), 2, 0, 2, "Bomb");
  // maps start with file named map+mapCount
  mapCount = 0;
  size(1280, 720);
  frameRate(60);
  noSmooth();
  background(backgroundColor);
  loadMap("Maps/map"+mapCount+".txt", "chars.txt");
  player = new Player(0, 0, loadImage("graphics/player.png"));
  mainMenuSetup();
  selector = loadImage("graphics/selected.png");
  exp_hori_img = loadImage("graphics/exp_horizontal.png");
  exp_vert_img = loadImage("graphics/exp_vertical.png");
  exp_middle_img = loadImage("graphics/exp_middle.png");
  scale(0.1);
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

// switch case structure to monitor state of the game
void draw() {

  
  switch(state) {
  case State.WAIT_USER_INPUT:
    mainMenuDraw();
    break;
  case State.STORY:
    printStory();
    break;
  case State.GAME:
    background(backgroundColor);
    //println(frameRate);
    drawBackground();
    drawMap();
    processFlames();
    processBombs();
    drawBoulders();
    processBoulders();
    drawScore();
    drawInventory();
    drawKeycount();
    player.move();
    player.drawPlayer();

    for (int i = 0; i < creeps.size(); i++)
    {
      Creep creep = creeps.get(i);
      if (abs(second()-lastMove) > 0.5)
        creep.moveRandom();
      if (creep != null)
        creeps.get(i).draw();
    }

    if (abs(second()-lastMove) > 0.5)
      lastMove = second();
    break;
  
  case State.PAUSE:
    textAlign(CENTER);
    fill(69,420,1337); // dank color
    text("PAUSED", width/2, height/3+50);
    text("press p to continue", width/2, height/3+100);
    break;
  
  case State.END:
    printScores();
    break;
  }
}
void drawBoulders() { // draws the boulders in the boulders list.

  for (Boulder boulder : boulders) {
    image(boulder.image, 32*boulder.x, 32*boulder.y+8);
  }
}

void processBoulders() {
  if (millis()- time > 500) {
    Boolean flag = false;
    for (int i = boulders.size() - 1; i >= 0 ; i--) {
      map[boulders.get(i).x][boulders.get(i).y].empty = false;
      map[boulders.get(i).x][boulders.get(i).y].tileHp = -1;
      if (boulders.get(i).y <= 20 && map[boulders.get(i).x][boulders.get(i).y+1].empty == true) { // empty tile beneath the boulder
        //println(boulders.get(i).y+"  " + boulders.get(i).x+ "  " +map[boulders.get(i).x][boulders.get(i).y].empty);
        if (!playerIsBelow(boulders.get(i).x,boulders.get(i).y) && !creepIsBelow(boulders.get(i).x, boulders.get(i).y)) { // no tiles or players or creeps below the boulder
          boulders.get(i).hasMomentum = true;
          map[boulders.get(i).x][boulders.get(i).y].empty = true;
          map[boulders.get(i).x][boulders.get(i).y].tileHp = 2;
          boulders.get(i).y += 1;
          map[boulders.get(i).x][boulders.get(i).y].empty = false;
          map[boulders.get(i).x][boulders.get(i).y].tileHp = -1;
        } else if (playerIsBelow(boulders.get(i).x, boulders.get(i).y) == true && boulders.get(i).hasMomentum == true) { // boulder has momentum and the player is beneath it
          flag = true;
          break;
        } else if (playerIsBelow(boulders.get(i).x, boulders.get(i).y) == true && boulders.get(i).hasMomentum == false) {//  player is below but boulder has no momentum
        } else if (creepIsBelow(boulders.get(i).x, boulders.get(i).y) == true && boulders.get(i).hasMomentum == true) { // boulder has momentum and a creep is beneath it
          Creep deadCreep = null;
          for (Creep creep : creeps)
          {
            if (creep.x == boulders.get(i).x && creep.y == boulders.get(i).y+1) {
              deadCreep = creep;
              break;
            }
          }
          if (deadCreep != null)
            deadCreep.kill();
          boulders.get(i).y += 1;
        } else if (creepIsBelow(boulders.get(i).x, boulders.get(i).y) == true && boulders.get(i).hasMomentum == false) {//  creep is below a boulder but the boulder has no momentum
        }
      } else {
        boulders.get(i).hasMomentum = false;
      }
    }
    if (flag)
      endGame();
    time = millis();
  }
}

Boolean creepIsBelow(int x, int y) {
  for (Creep creep : creeps)
  {
    if (creep.x == x && creep.y == y+1) {
      return true;
    }
  }
  return false;
}

Boolean playerIsBelow(int x, int y) {
  if (player.getX() == x && player.getY() == y+1) {
    return true;
  }
  return false;
}


void boulderHit(int x, int y, Boolean momentum ) {
  if (player.getX() == x && player.getY() == y+1 && momentum == true) {
    endGame();
  }
}

void processFlames() {
  List<Flame> deadFlames = new ArrayList<Flame>();
  Boolean dead = false;
  for (Flame flame : flames) {
    image(flame.image, 32*flame.x, 32*flame.y+8);
    if (player.getX() == flame.x && player.getY() == flame.y) {
      dead = true;
      break;
    }
    Creep deadCreep = null;
    for (Creep creep : creeps) {
      if (creep.x == flame.x && creep.y == flame.y) {
        deadCreep = creep;
        break;
      }
    }
    if (deadCreep != null)
      deadCreep.kill();
    if (millis() >= flame.flameTimer)
      deadFlames.add(flame);
  }
  if (dead)
    endGame();
  for (Flame deadFlame : deadFlames)
    flames.remove(deadFlame);
}

void processBombs() {
  List<Bomb> explodedBombs = new ArrayList<Bomb>();
  for (Bomb bomb : bombs) {
    image(bomb.icon, bomb.x*32, bomb.y*32+8);
    if (bomb.explosive && bomb.bombTimer <= millis()) {
      explodedBombs.add(bomb);
      bomb.explode();
    }
  }
  for (Bomb explodedBomb : explodedBombs)
    bombs.remove(explodedBomb);
}

void printScores() { /// prints the scores.txt file into the highscore view
  background(0);
  fill(0, 102, 153);
  textAlign(CENTER);
  String[] lines =loadStrings("scores.txt");
  textSize(32);
  text("HIGHSCORE", width/2, 40);
  textAlign(LEFT);
  text("Player", 465, 100);
  text("Points", 730, 100);
  textSize(14);
  int gum = 1;
  for (String x : lines) {
    String[] info = x.split(" ");
    text(gum+ ". "+ info[1], 465, 130+(gum*20));
    text(info[0], 730, 130+(gum*20));
    gum +=1;
    if (gum == 16) {
      break;
    }
  }
}

void storyEnd() {
  state = State.GAME;
}


void drawScore() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(CENTER);
  text("Score:"+player.score, width/2, 32);
}

void drawInventory() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(LEFT);
  int axis = 200;
  for (AbstractItem item : player.inventory) {
    image(item.icon, axis, 10);
    if (player.inventory.get(player.selectedItem) == item) {
      image(selector, axis, 10);
    }
    text(item.thisBombLeft, axis+9, 72);
    axis += 48;
  }
  /*if (player.selectedItem > -1);
   text("Item: "+player.inventory.get(player.selectedItem).itemName, 0, 32);*/
}

void drawKeycount() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(RIGHT);
  text("Keys: "+player.keys+"/3", 1280, 32);
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
  case State.PAUSE:
  }
}

void keyPressed() {
  switch(state) {
  case State.WAIT_USER_INPUT:

    break;
  case State.STORY:
    break;
  case State.GAME:
    pauseKeyPressed();
    movementKeyPressed();
    useKeyPressed();
    break;
  case State.PAUSE:
    movementKeyReleased();
    pauseKeyPressed();
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
  case State.PAUSE:
    movementKeyReleased();
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

  case State.END:
    if (mousePressed) {
      if (mouseX>=300 && mouseX <=600 && mouseY>600 && mouseY <650) {
        state = State.WAIT_USER_INPUT;
        resetKeyboardInputs();
        setup();
        deleteHighscoreButtons();
      }
      if (mouseX>=690 && mouseX <=990 && mouseY>600 && mouseY <650) {
        exit();
      }
    }
  }
}

void endGame() {
  state = State.END;
  if (loadStrings("scores.txt")==null) {
    PrintWriter output;
    output = createWriter("scores.txt");
    output.println(player.score+" "+playerName);
    output.flush();
    output.close();
  } else {
    String[] strings = loadStrings("scores.txt");
    saveStrings("scores.txt", new String[]{});
    PrintWriter output = createWriter("scores.txt");
    Boolean found = false;
    int i = 0;
    while (i < strings.length) {
      if ((int(split(strings[i], ' ')[0]) < player.score && !found)) {
        found = true;
        output.println(player.score+" "+playerName);
      } else {
        output.println(strings[i]);
        i++;
      }
    }
    if (!found)
      output.println(player.score+" "+playerName);
    output.flush();
    output.close();
  }
  scores = loadStrings("scores.txt");
  state = State.END;
  highscoreSetup();
  clearMap();
}

void clearMap() {
  flames.clear();
  bombs.clear();
  creeps.clear();
  pickups.clear();
  boulders.clear();
}

void newLevel() {
  mapCount++;
  clearMap();
  resetKeyboardInputs();   
  loadMap("Maps/map"+mapCount+".txt", "chars.txt");
  player.reset();
  exp_hori_img = loadImage("graphics/exp_horizontal.png");
  exp_vert_img = loadImage("graphics/exp_vertical.png");
  exp_middle_img = loadImage("graphics/exp_middle.png");
}