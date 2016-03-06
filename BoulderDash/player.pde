

class Player {
  int score = 0;
  float x = 0;
  float y = 0;
  float speed = 32;
  int selectedItem = -1;
  int MAXITEMS = 10;


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

  void move() {
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();

    if (up == 1 && gridY > 0) {
      if (this.is_mineable(gridX, gridY-1) == true) {
        if (map[gridX][gridY-1].tile_hp > 0) {
          map[gridX][gridY-1].tile_hp -= 1;
          return;
        }
        map[gridX][gridY-1].destroy();
      }

      if (map[gridX][gridY-1].empty == true) {

        y -= speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkPickup();
      }
    } else if (down == 1 && gridY < 21) {
      if ( this.is_mineable(gridX, gridY+1) == true) {
        if (map[gridX][gridY+1].tile_hp > 0) {
          map[gridX][gridY+1].tile_hp -= 1;
          return;
        }
        map[gridX][gridY+1].destroy();
      }

      if (map[gridX][gridY+1].empty == true) {

        y += speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkPickup();
      }
    } else if (left == 1 && gridX > 0) {
      if (this.is_mineable(gridX-1, gridY) == true) {
        if (map[gridX-1][gridY].tile_hp > 0) {
          map[gridX-1][gridY].tile_hp -= 1;
          return;
        }
        map[gridX-1][gridY].destroy();
      }

      if (map[gridX-1][gridY].empty == true) {

        x -= speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkPickup();
      } else {
        println("seinä");
      }
    } else if (right == 1 && gridX < 39) {
      if (this.is_mineable(gridX+1, gridY) == true) {
        if (map[gridX+1][gridY].tile_hp > 0) {
          map[gridX+1][gridY].tile_hp -= 1;
          return;
        }
        map[gridX+1][gridY].destroy();
      }

      if (map[gridX+1][gridY].empty == true) {

        x += speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkPickup();
      }
    }
  }
  
  void drop_bomb(Bomb bomb){
    bombs.add(bomb);
    bomb.setPosition(this.getGridPosX(), this.getGridPosY());
    
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
  
  void inventory() {
    if (rotateleft == 1 && changedItem == 0) {
      changedItem = 1;
      --selectedItem;
      if (selectedItem < 0) {
        selectedItem = -1;
      }
      println(selectedItem);
    }
    if (rotateright == 1 && changedItem == 0) {
      changedItem = 1;
      ++selectedItem;
      if (selectedItem > MAXITEMS) {
        selectedItem = MAXITEMS;
      }
      println(selectedItem);
    }
  }
}

void checkCreep(int x, int y) {
  for (Creep creep : creeps)
    if (creep.x == x && creep.y == y)
      endGame();
}