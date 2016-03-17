class Player {
  int score = 0;
  float x = 0;
  float y = 0;
  PImage icon;
  float speed = 32;
  int selectedItem = -1;
  int keys = 0;
  List<Item> inventory = new ArrayList<Item>();
  int bombsLeft = 1;


  Player(int _x, int _y, PImage icon_) {
    x = _x;
    y = _y;
    icon = icon_;
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
    image(icon, x, y);
  }

  void move() {
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();

    if (up == 1 && gridY > 0) {
      if (this.is_mineable(gridX, gridY-1) == true) {
        if (map[gridX][gridY-1].tileHp > 0) {
          map[gridX][gridY-1].tileHp -= 1;
          return;
        }
        map[gridX][gridY-1].destroy();
      }

      if (map[gridX][gridY-1].empty == true) {

        y -= speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkItem();
      }
    } else if (down == 1 && gridY < 21) {
      if ( this.is_mineable(gridX, gridY+1) == true) {
        if (map[gridX][gridY+1].tileHp > 0) {
          map[gridX][gridY+1].tileHp -= 1;
          return;
        }
        map[gridX][gridY+1].destroy();
      }

      if (map[gridX][gridY+1].empty == true) {

        y += speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkItem();
      }
    } else if (left == 1 && gridX > 0) {
      if (this.is_mineable(gridX-1, gridY) == true) {
        if (map[gridX-1][gridY].tileHp > 0) {
          map[gridX-1][gridY].tileHp -= 1;
          return;
        }
        map[gridX-1][gridY].destroy();
      }

      if (map[gridX-1][gridY].empty == true) {

        x -= speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkItem();
      } else {
        println("seinä");
      }
    } else if (right == 1 && gridX < 39) {
      if (this.is_mineable(gridX+1, gridY) == true) {
        if (map[gridX+1][gridY].tileHp > 0) {
          map[gridX+1][gridY].tileHp -= 1;
          return;
        }
        map[gridX+1][gridY].destroy();
      }

      if (map[gridX+1][gridY].empty == true) {

        x += speed;
        this.drawPlayer();
        checkCreep(getGridPosX(), getGridPosY());
        //delay(40);
        checkItem();
      }
    }
  }

  // can the tile be mined
  boolean is_mineable(int gridX, int gridY) {
    if (map[gridX][gridY].tileHp > -1) {
      return true;
    } else {
      return false;
    }
  }

  // does our current tile have an item
  void checkItem()
  {
    int gridX = this.getGridPosX();
    int gridY = this.getGridPosY();
    if (map[gridX][gridY].item != null) {
      Item item = map[gridX][gridY].item;
      player.score += map[gridX][gridY].item.score;
      player.inventory.add(item);
      map[gridX][gridY].item = null;
    }
  }
}

void checkCreep(int x, int y) {
  for (Creep creep : creeps)
    if (creep.x == x && creep.y == y)
      endGame();
}