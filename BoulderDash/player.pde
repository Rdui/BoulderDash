

class Player {
  int score = 0;
  float x = 0;
  float y = 0;
  float speed = 32;




  Player(int _x, int _y) {
    x = _x;
    y = _y;
  }

  void setCoordinates(int _x, int _y) {
    x = _x;
    y = _y;
  }

  int getGridPosX() {
    int gridX = 0;
    gridX = round(x)/32;
    return gridX;
  }

  int getGridPosY() {
    int gridY = 0;
    gridY = round(y)/32;
    return gridY;
  }

  void drawPlayer() {
    image(img, x, y);
    //println(this.getGridPosX() + " " + this.getGridPosY());
    //println(this.x + " " + this.y);
  }

  void erasePlayer() {
    //fill(backgroundColor);
    //rect(x, y, 32, 32);
  }

  void move() {
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();

    if (up == 1 && gridY > 0) {
      if (this.is_mineable(gridX, gridY-1) == true) {
        if(map[gridX][gridY-1].tile_hp > 0){
          map[gridX][gridY-1].tile_hp -= 1;
          return;
        }
        map[gridX][gridY-1].empty = true;
        map[gridX][gridY-1].tile_type = 0;
      }

      if (map[gridX][gridY-1].empty == true) {
        this.erasePlayer();
        y -= speed;
        this.drawPlayer();
        delay(40);
        checkPickup();
      }
    } else if (down == 1 && gridY < 21) {
      if ( this.is_mineable(gridX, gridY+1) == true) {
        if(map[gridX][gridY+1].tile_hp > 0){
          map[gridX][gridY+1].tile_hp -= 1;
          return;
        }
        map[gridX][gridY+1].empty = true;
        map[gridX][gridY+1].tile_type = 0;
      }

      if (map[gridX][gridY+1].empty == true) {
        this.erasePlayer();
        y += speed;
        this.drawPlayer();
        delay(40);
        checkPickup();
      }
    } else if (left == 1 && gridX > 0) {
      if (this.is_mineable(gridX-1, gridY) == true) {
        if(map[gridX-1][gridY].tile_hp > 0){
          map[gridX-1][gridY].tile_hp -= 1;
          return;
        }
        map[gridX-1][gridY].empty = true;
        map[gridX-1][gridY].tile_type = 0;
      }

      if (map[gridX-1][gridY].empty == true) {
        this.erasePlayer();
        x -= speed;
        this.drawPlayer();
        delay(40);
        checkPickup();
      } else {
        println("seinä");
      }
    } else if (right == 1 && gridX < 39) {
      if (this.is_mineable(gridX+1, gridY) == true) {
        if(map[gridX+1][gridY].tile_hp > 0){
          map[gridX+1][gridY].tile_hp -= 1;
          return;
        }
        map[gridX+1][gridY].empty = true;
        map[gridX+1][gridY].tile_type = 0;
      }

      if (map[gridX+1][gridY].empty == true) {
        this.erasePlayer();
        x += speed;
        this.drawPlayer();
        delay(40);
        checkPickup();
      }
    }
  }

  boolean is_mineable(int gridX, int gridY) {
    println(" edessä olevan tiilen tile_type: " + map[gridX][gridY].tile_type);
    if (map[gridX][gridY].tile_type !=10) {
      return true;
    } else {
      return false;
    }
  }

  void checkPickup()
  {
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();
    if (map[gridX][gridY].pickup != null) {
      player.score += map[gridX][gridY].pickup.score;
      map[gridX][gridY].pickup = null;
      println(gridX, gridY);
    }
  }
}