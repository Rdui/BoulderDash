

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
        map[gridX][gridY-1].empty = true;
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
        map[gridX][gridY+1].empty = true;
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
        map[gridX-1][gridY].empty = true;
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
        map[gridX+1][gridY].empty = true;
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
    if (map[gridX][gridY].canWalk == true) {
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