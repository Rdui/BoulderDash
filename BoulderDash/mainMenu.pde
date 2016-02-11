// Täällä määritellään mainMenun toiminnalisuus


String playerName = "";
GButton startButton;
GEvent buttonEvent;

void mainMenuSetup(){
  startButton = new GButton(this, width/2.67, height/2.2, 400, 50, "Aloita peli!");
}


void mainMenuDraw(){
  
  // "Syötä pelaajan nimi"
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Syötä pelaajan nimi", width/2, height/3);
  
  //tekstikentän laatikko
  fill(204, 153, 51);
  rectMode(CENTER);
  rect(width/2, height/2.5, 400, 50, 25, 5, 25, 5);
  // itse teksti
  fill(22);
  text(playerName, width/2, height/2.45);
   
}

// hallitaan nimi input textiä
void mainMenuKeyTyped(){
  if(key == '\b'){
      if(playerName.length() >= 1){
          playerName = playerName.substring(0, playerName.length() - 1); 
      }
  }
  else{
     if(key != '\n'){
        playerName += key; 
     }
  }
}
// Käsitellään nappulan eventti
void handleButtonEvents(GButton button, GEvent event) {
  if (button == startButton && event == GEvent.CLICKED) {
    println("peli alkaa " + playerName);
    //resetataan canvas
    
    button.dispose();
    
    state = State.STORY;
    
  }
  else{
     
  }
}