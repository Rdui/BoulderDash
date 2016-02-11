import g4p_controls.*;

// Gamestate. käytetään hallinnoimaan mitä koodia suoritetaan kun peli käynnissä.
// mainmenu, intro, game, gameover jne. lisätään tarpeen mukaan.
interface State {
  byte WAIT_USER_INPUT = 0;
  byte STORY = 1;
  byte GAME= 2;
}


byte state = State.WAIT_USER_INPUT;

color backgroundColor = color(22);

void setup() {
  background(backgroundColor);
  size(1280, 720);
  loadMap("map.txt", "chars.txt");
  mainMenuSetup();
}

void printStory() {
  background(0);
  fill(0, 102, 153);
  textSize(14);
  text(playerName + " has fallen into a cave!", width/2-100, height/3);
  text("He has his smartphone with him and all necessary things to alert help", width/2-100, height/3+50);
  text("BUT, because " + playerName + " is such a manly man, he won't accept help from anyone!", width/2-100, height/3+70);
  text(playerName + " only has his boisterous biceps, his cutting edge brains and random tools found in the cave to aid him.", width/2-100, height/3+90);
  text("Good luck " + playerName + "!", width/2-100, height/3+120);
  textSize(20);
  text("Press any key to continue", width/2-100, height/3+200);
}

void storyEnd() {
  state = State.GAME;
}

// switch case rakenne gamestaten tarkkailuun
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
    for (int y = 0; y < map[0].length; y++) {
      for (int x = 0; x < map.length; x++) {
        image(map[x][y].image, x*32, y*32);
      }
    }
    //Tähän tulee funktio josta peli alkaa
    // pelaajan nimi: String playerName
    break;


    //Tähän tulee funktio josta peli alkaa
    // pelaajan nimi: String playerName
  }
}
// switch case rakenne gamestaten tarkkailuun
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

// switch case rakenne gamestaten tarkkailuun
void mousePressed() {
  switch(state) {
  case State.WAIT_USER_INPUT:
    // mainMenuKeyTyped();
    break;
  case State.GAME:

    break;
  }
}