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
  size(1600, 900);
  mainMenuSetup();

}
               

// switch case rakenne gamestaten tarkkailuun
void draw(){
  background(backgroundColor);
  switch(state){
    case State.WAIT_USER_INPUT:
      mainMenuDraw();
    break;    
    case State.GAME:   
    //Tähän tulee funktio josta peli alkaa
    // pelaajan nimi: String playerName
    break;
 
  
  //Tähän tulee funktio josta peli alkaa
  // pelaajan nimi: String playerName
}

}
// switch case rakenne gamestaten tarkkailuun
void keyTyped(){
  switch(state){
    case State.WAIT_USER_INPUT:
      mainMenuKeyTyped();
    
    break;
    case State.GAME:
    
    break;
  }
  
}

// switch case rakenne gamestaten tarkkailuun
void mousePressed(){
    switch(state){
    case State.WAIT_USER_INPUT:
      mainMenuKeyTyped();
    
    break;
    case State.GAME:
    
    break;
  }
}