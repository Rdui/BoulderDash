class Bomb extends Item {
  Tile tile; // reference to tile the bomb is on
  int delay; // bomb time in s
  PImage icon;
  int bomb_type;
  int radius;
  int shape;
  int x;
  int y;
  int bomb_timer;

  Bomb(PImage icon_, int radius_, int shape_) {
    super(icon_, 0, true);
    icon = icon_;
    radius = radius_;
    shape = shape_;
  }
  
  void Use(Item item){
    Bomb bomb = (Bomb)item;
    bombs.add(bomb);
    bomb.setPosition(player.getGridPosX(), player.getGridPosY());
  }


  void setPosition(int x_, int y_) {
    x = x_;
    y = y_;
  }

  // draws and checks if the bomb should explode
  void draw() {
    image(icon, x*32, y*32+8);
    this.bomb_timer -= 1;
    if (this.bomb_timer == 0) {
      this.explode();
    }
  }


  // clears breakable things from the exploding bombs blast radius
  void explode() {
    if (shape == 0) {
      kill(x, y);
      Flame middle = new Flame(0);
      middle.makeFlame(x, y);

      for (int i = 1; i <= radius; i++) {
        if (x + i <= 39) {
          if (map[x+i][y].empty == true) {
            continue;
          }
          map[x+i][y].destroy(); // destroys the tile in that position, if it can be destroyed
          kill(x+i, y); // checks if the player or a creep is in that position and kills it
          Flame flame = new Flame(1);
          flame.makeFlame(x+i, y);
          //image(exp_vert, (x+i)*32, y*32+8);
        }
      }
      for (int i = 1; i <= radius; i++) {
        if (x - i >= 0) {
          if (map[x-i][y].empty) {
            continue;
          }
          map[x-i][y].destroy();
          kill(x-i, y);
          Flame flame = new Flame(1);
          flame.makeFlame(x-i, y);
        }
      }
      for (int i = 1; i <= radius; i++) {
        if (y + i <= 21) {
          if (map[x][y+1].empty) {
            continue;
          }
          map[x][y+i].destroy();
          kill(x, y+i);
          Flame flame = new Flame(2);
          flame.makeFlame(x, y+i);
          //image(exp_hori, x*32, (y+i)*32+8);
        }
      }
      for (int i = 1; i <= radius; i++) {
        if (y - i >= 0) {
          if (map[x][y-1].empty) {
            continue;
          }
          map[x][y-i].destroy();
          kill(x, y-i);
          Flame flame = new Flame(2);
          flame.makeFlame(x, y-i);
          //image(exp_hori, x*32, (y-i)*32+8);
        }
      }
    }
  }

  void kill(int x, int y) {
    if (player.getGridPosX() == x && player.getGridPosY() == y) {
      endGame();
    }
    // tähän voisi laittaa tarkastelun siitä osuuko pommin räjähdys creeppiiiinn
  }
}