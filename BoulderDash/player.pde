class Player {
  int score = 0;
  float x = 0;
  float y = 0;
  PImage icon;
  float speed = 32;
  int selectedItem = -1;
  int keys = 0;
  List<AbstractItem> inventory = new ArrayList<AbstractItem>();
  int bombsLeft = 2;


  Player(int _x, int _y, PImage icon_) {
    x = _x;
    y = _y;
    icon = icon_;
    setCoordinates(startX*32, startY*32+8);
    inventory.add(basicBomb);
    selectedItem = 0;
  }

  void reset() {
    x = 0;
    y = 0;
    keys = 0;
    setCoordinates(startX*32, startY*32+8);
    
    if (player.inventory.size() == 0){
      inventory.add(new Bomb(loadImage("graphics/smallbomb.png"), 2, 0, 2, "Bomb"));
    }
    else{
      for (AbstractItem listItem : player.inventory) {
        listItem.thisBombLeft += 1; 
      }
    }
    
    selectedItem = 0;
  }

  void setCoordinates(int _x, int _y) {
    x = _x;
    y = _y;
  }
  int getX() {
    int gridX = 0;
    gridX = round(x)/32;
    return gridX;
  }

  int getY() {
    int gridY = 0;
    gridY = round(y)/32;
    return gridY;
  }

  void drawPlayer() {
    image(icon, x, y);
  }

  // reduce tile health to the direction we are moving or move if there is no tile
  void move() {
    int gridX = this.getX();
    int gridY = this.getY();

    if (up == 1 && gridY > 0) {
      if (this.is_mineable(gridX, gridY-1)) {

        if (map[gridX][gridY-1].tileHp > 0) {
          map[gridX][gridY-1].tileHp -= 1;
          return;
        }
        map[gridX][gridY-1].destroy();
      }

      if (map[gridX][gridY-1].empty == true) {

        y -= speed;
        if (!soundWalking.isPlaying())
          soundWalking.rewind();
        soundWalking.play();
        checkCreep(getX(), getY());
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
        if (!soundWalking.isPlaying())
          soundWalking.rewind();
        soundWalking.play();
        checkCreep(getX(), getY());
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
        if (!soundWalking.isPlaying())
          soundWalking.rewind();
        soundWalking.play();
        checkCreep(getX(), getY());
        checkItem();
      } else {
      }
    } else if (right == 1 && gridX < 39) {
      if (this.is_mineable(gridX+1, gridY) == true) {
        if (map[gridX+1][gridY].tileHp >  0) {
          map[gridX+1][gridY].tileHp -= 1;
          return;
        }
        map[gridX+1][gridY].destroy();
      }

      if (map[gridX+1][gridY].empty == true) {
        x += speed;
        if (!soundWalking.isPlaying())
          soundWalking.rewind();
        soundWalking.play();
        checkCreep(getX(), getY());
        checkItem();
      }
    }
  }

  // can the tile be mined
  boolean is_mineable(int gridX, int gridY) {
    for (Boulder boulder : boulders) {
      if (boulder.x == gridX && boulder.y == gridY) {
        return false;
      }
    }
    if (map[gridX][gridY].tileHp > -1) {
      return true;
    } else {
      return false;
    }
  }

  // does our current tile have an item
  void checkItem()
  {
    int gridX = this.getX();
    int gridY = this.getY();
    Boolean exists = false;
    if (map[gridX][gridY].item != null) {
      soundPickup.rewind();
      soundPickup.play();
      for (AbstractItem listItem : player.inventory) {
        if (listItem.itemName.equals( map[gridX][gridY].item.itemName)) {
          exists = true;
          listItem.thisBombLeft += 1;
          break;
        }
      }
      if (exists == false) {
        AbstractItem item = map[gridX][gridY].item;
        player.inventory.add(item);
      }

      player.score += map[gridX][gridY].item.score;

      pickups.remove(map[gridX][gridY].item);
      map[gridX][gridY].item = null;
    }
    if (map[gridX][gridY].portalkey)
    {
      map[gridX][gridY].portalkey = false;
      player.keys += 1;
      if (player.keys == 3) {
        soundGateOpen.rewind();
        soundGateOpen.play();
      }
    } else if (map[gridX][gridY].portal && player.keys == 3) {
      fade = millis()+2000;
      state = State.NEWLEVEL;
    }
  }
}

void checkCreep(int x, int y) {
  Boolean flag = false;
  for (Creep creep : creeps)
    if (creep.x == x && creep.y == y)
      flag = true;
  if (flag)
    endGame();
}