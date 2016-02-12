

class Player {
  int score = 0;
  float x = 0;
  float y = 0;
  float speed = 5;
  
  
  
  
  Player(int _x, int _y) {
    x = _x;
    y = _y;
  }
  
  void setCoordinates(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  int getGridPosX(){
    int gridX = 0;
    gridX = round(x)/32;
    return gridX;
  }
  
  int getGridPosY(){
    int gridY = 0;
    gridY = round(y)/32;
    return gridY;
  }
  
  void drawPlayer(){
    image(img, x, y);
    println(this.getGridPosX() + " " + this.getGridPosY());
    println(this.x + " " + this.y);
  }
  
  void erasePlayer(){
    //fill(backgroundColor);
    //rect(x, y, 32, 32);
  }
  
  void move(){
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();
    if(up == 1){
      if(map[gridX][gridY-1].empty == true){
        this.erasePlayer();
        y -= speed;
        this.drawPlayer();
      }
    }
    else if(down == 1){
      if(map[gridX][gridY+1].empty == true){
        this.erasePlayer();
        y += speed;
        this.drawPlayer();
      }
    }
    else if(left == 1){
      if(map[gridX-1][gridY].empty == true){
        this.erasePlayer();
        x -= speed;
        this.drawPlayer();
      }else{
        println("seinä");
      }  
    }
    else if(right == 1){
      if(map[gridX+1][gridY].empty == true){
        this.erasePlayer();
        x += speed;
        this.drawPlayer();
      }
      
      
    }    
  }
}