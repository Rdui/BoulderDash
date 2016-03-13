class Flame {
  PImage exp_vert;
  PImage exp_hori;
  PImage exp_middle;

  int pos_x;
  int pos_y;

  int flameType;

  int flame_time = 35;
  Flame(int type) {
    exp_vert = exp_vert_img;
    exp_hori = exp_hori_img;
    exp_middle = exp_middle_img;

    flameType = type;
  }

  void setPosition(int x, int y) {
    println(x+y);
    pos_x = x;
    pos_y = y;
  }

  void makeFlame(int pos_x, int pos_y) {
    flames.add(this);
    this.setPosition(pos_x, pos_y);
  }

  int getFlamePosX() {
    return this.pos_x;
  }
  int getFlamePosY() {
    return this.pos_y;
  }

  void kill(int x, int y) {
    if (player.getGridPosX() == x && player.getGridPosY() == y) {
      endGame();
    }
  }


  void draw() {
    if (flameType == 0) {
      image(exp_middle, pos_x*32, pos_y*32+8);
    } else if (flameType == 1) {
      kill(this.getFlamePosX(), this.getFlamePosY());
      image(exp_vert, pos_x*32, pos_y*32+8);
    } else if (flameType == 2) {
      kill(this.getFlamePosX(), this.getFlamePosY());
      image(exp_hori, pos_x*32, pos_y*32+8);
    }

    this.flame_time -= 1;
  }
  

}