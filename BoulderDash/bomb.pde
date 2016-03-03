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
    

  
  void explode() {
    
    if(explosion_shape == 0){
      for(int i = 1; i <= explosion_radius; i++){
        if(pos_x + i <= 39){
          map[pos_x+i][pos_y].destroy();
          image(exp_vert, (pos_x+i)*32, pos_y*32+8);
        }
        if(pos_x - i >= 0){
          map[pos_x-i][pos_y].destroy();
          image(exp_vert, (pos_x-i)*32, pos_y*32+8);
        }
        if(pos_y + i <= 21){
          map[pos_x][pos_y+i].destroy();
          image(exp_hori, pos_x*32, (pos_y+i)*32+8);
        }
        if(pos_y - i >= 0){
          map[pos_x][pos_y-i].destroy();
          image(exp_hori, pos_x*32, (pos_y-i)*32+8);
        }
      }
    }
    else if(explosion_shape == 1){
      map[pos_x+1][pos_y].destroy();
      map[pos_x][pos_y+1].destroy();
      map[pos_x-1][pos_y].destroy();
      map[pos_x][pos_y-1].destroy();
      map[pos_x+2][pos_y].destroy();
      map[pos_x][pos_y+2].destroy();
      map[pos_x-2][pos_y].destroy();
      map[pos_x][pos_y-2].destroy();
    }
  }
}