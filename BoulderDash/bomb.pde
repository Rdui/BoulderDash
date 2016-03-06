class Bomb {
  Tile tile;
  int delay;
  PImage bombIcon;
  PImage exp_vert;
  PImage exp_hori;
  int bomb_type;
  
  int explosion_radius;
  int explosion_shape;
  
  int pos_x;
  int pos_y;
  
  int bomb_timer;
  
  Bomb(int bombType) {
    if(bombType == 1) {
      bomb_type = bombType; 
      explosion_radius = 2;
      explosion_shape = 0;
      bombIcon = bomb_1_img;
      exp_vert = exp_vert_img;
      exp_hori = exp_hori_img;
      bomb_timer = 50;
    }
  }
  
  
  void setPosition(int x, int y){
    pos_x = x;
    pos_y = y;
  }
  
  // draws and checks if the bomb should explode
  void draw(){
    println("pommi piirretty");
    println(bomb_type);
    if(bomb_type == 1){
      image(bombIcon, pos_x*32, pos_y*32+8);
    }
    this.bomb_timer -= 1;
    
    if(this.bomb_timer == 0){
      this.explode();
    }
  }
    

  
  void explode() { // clears breakable things from the exploding bombs blast radius
    
    if(explosion_shape == 0){
      kill(pos_x, pos_y);
      for(int i = 1; i <= explosion_radius; i++){
        if(pos_x + i <= 39){
          if (map[pos_x+i][pos_y].tile_type == 10){
            continue;
          }
          map[pos_x+i][pos_y].destroy(); // destroys the tile in that position, if it can be destroyed
          kill(pos_x+i, pos_y); // checks if the player or a creep is in that position and kills it
          image(exp_vert, (pos_x+i)*32, pos_y*32+8);
        }
      }
      for(int i = 1; i <= explosion_radius; i++){
        if(pos_x - i >= 0){
          if (map[pos_x-i][pos_y].tile_type == 10){
            continue;
          }
          map[pos_x-i][pos_y].destroy();
          kill(pos_x-i, pos_y);
          image(exp_vert, (pos_x-i)*32, pos_y*32+8);
        }
      }
      for(int i = 1; i <= explosion_radius; i++){
        if(pos_y + i <= 21){
          if (map[pos_x][pos_y+1].tile_type == 10){
            continue;
          }
          map[pos_x][pos_y+i].destroy();
          kill(pos_x, pos_y+i);
          image(exp_hori, pos_x*32, (pos_y+i)*32+8);
        }
      }
      for(int i = 1; i <= explosion_radius; i++){
        if(pos_y - i >= 0){
          if (map[pos_x][pos_y-1].tile_type == 10){
            continue;
          }
          map[pos_x][pos_y-i].destroy();
          kill(pos_x, pos_y-i);
          image(exp_hori, pos_x*32, (pos_y-i)*32+8);
        }
      }  
    }
    /*else if(explosion_shape == 1){
      map[pos_x+1][pos_y].destroy();
      map[pos_x][pos_y+1].destroy();
      map[pos_x-1][pos_y].destroy();
      map[pos_x][pos_y-1].destroy();
      map[pos_x+2][pos_y].destroy();
      map[pos_x][pos_y+2].destroy();
      map[pos_x-2][pos_y].destroy();
      map[pos_x][pos_y-2].destroy();
    }*/
  }
  
  void kill(int x, int y){
    if(player.getGridPosX() == x && player.getGridPosY() == y){
      endGame();
    }
    // tähän voisi laittaa tarkastelun siitä osuuko pommin räjähdys creeppiiiinn
    
  }
}