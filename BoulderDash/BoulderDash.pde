import g4p_controls.*;

// Gamestate. käytetään hallinnoimaan mitä koodia suoritetaan kun peli käynnissä.
// mainmenu, intro, game, gameover jne. lisätään tarpeen mukaan.
interface State {          
  byte WAIT_USER_INPUT = 0;             
  byte GAME= 1;
}


byte state = State.WAIT_USER_INPUT;

color backgroundColor = color(22);

void setup() {
  background(backgroundColor);
  size(1280, 720);
  loadMap("map.txt", "chars.txt");
  mainMenuSetup();
}


// switch case rakenne gamestaten tarkkailuun
void draw() {
  background(backgroundColor);
  switch(state) {
  case State.WAIT_USER_INPUT:
    mainMenuDraw();
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
  case State.GAME:

    break;
  }
}

// switch case rakenne gamestaten tarkkailuun
void mousePressed() {
  switch(state) {
  case State.WAIT_USER_INPUT:
    mainMenuKeyTyped();

    break;
  case State.GAME:

    break;
  }
}