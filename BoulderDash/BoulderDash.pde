import g4p_controls.*;
import java.io.File;

// Gamestate is used to define the state of the game
// mainmenu, intro, game, gameover etc. 
interface State {
  byte WAIT_USER_INPUT = 0;
  byte STORY = 1;
  byte GAME= 2;
  byte END = 3;
}


byte state = State.WAIT_USER_INPUT;

color backgroundColor = color(22);

Player player = new Player(0, 0);

PImage img;
PImage bomb_1_img;
PImage bomb_2_img;
PImage exp_hori_img;
PImage exp_vert_img;
PImage exp_middle_img;
PImage backgroundimage;
String[] scores;

GButton newGameButton;
GButton exitButton;



void setup() {
  background(backgroundColor);
  size(1280, 720);
  loadMap("map.txt", "chars.txt", "pickups.txt");
  mainMenuSetup();
  
  img = loadImage("graphics/tempModel.png");
  bomb_1_img = loadImage("graphics/bomb_1.png");
  bomb_2_img = loadImage("graphics/bomb_2.png");
  exp_hori_img = loadImage("graphics/exp_horizontal.png");
  exp_vert_img = loadImage("graphics/exp_vertical.png");
  exp_middle_img = loadImage("graphics/exp_middle.png");
  
  
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

void printScores(){ /// prints the scores.txt file into the highscore view
  background(0);
  fill(0, 102, 153);
  textAlign(CENTER);
  String[] lines =loadStrings("scores.txt");
  textSize(32);
  text("HIGHSCORE", width/2,40);
  textAlign(LEFT);
  text("Player", 465,100);
  text("Points", 730,100);
  textSize(14);
  int gum = 1;
  for (String x: lines){
    String[] info = x.split(" ");
    text(gum+ ". "+ info[1], 465, 130+(gum*20));
    text(info[0], 730, 130+(gum*20));
    gum +=1;
    if (gum == 16){
      break;
    }
  }
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
    drawItem();

    //println(startX + " " + startY);
    player.move();
    player.drawPlayer();
    player.inventory();
    
    for (int i = 0; i < creeps.size(); i++)
    {
      if (abs(second()-lastMove) > 0.5)
        creeps.get(i).moveRandom();
      creeps.get(i).draw();
    }
    if (abs(second()-lastMove) > 0.5)
      lastMove = second();

    
    for(int i = 0; i < bombs.size(); ++i){
      bombs.get(i).draw();
      if(bombs.get(i).bomb_timer == 0){
         bombs.remove(bombs.get(i)); 
      }
    }
    
    for(int i = 0; i < flames.size(); ++i){
      flames.get(i).draw();
      if(flames.get(i).flame_time == 0){
         flames.remove(flames.get(i)); 
      }
    }
    


    // Game starting function should be called here
    // players name: String playerName
    break;
  case State.END:
    printScores();
    
    
  }
}


void drawScore() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(CENTER);
  text("Score:"+player.score, width/2, 32);
}

void drawItem() {
  fill(255, 255, 255);
  textSize(25);
  textAlign(LEFT);
  text("Items: "+player.printItem(), 0, 32);
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
    bombKeyPressed();
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
    
  case State.END:
    if (mousePressed){
      if(mouseX>=300 && mouseX <=600 && mouseY>600 && mouseY <650){
        println("new game");
        state = State.WAIT_USER_INPUT;
        
        flames.clear();
        bombs.clear();
        creeps.clear();
        
        resetKeyboardInputs();
        
        
        setup();
        
        deleteHighscoreButtons();
      }
      if(mouseX>=690 && mouseX <=990 && mouseY>600 && mouseY <650){
        println("exit game");
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
}