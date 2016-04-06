class Tile {
  char c;
  PImage image; // tile graphics
  Boolean canWalk, empty, portalkey = false; // can the tile be mined, is it a clear space
  AbstractItem item; // item hidden in tile
  int tileHp;
  Bomb bomb;

  Tile(PImage i, Boolean cw, Boolean e, int hp) {
    image = i;
    canWalk = cw;
    empty = e;
    tileHp = hp;
  }

  // clone
  Tile(Tile another) {
    this.image = another.image;
    this.canWalk = another.canWalk;
    this.empty = another.empty;
    this.tileHp = another.tileHp;
    this.item = another.item;
  }

  //destroys this tile
  void destroy() {
    empty = true;
    tileHp = 2;
  }

  // sets an active bomb in the tile
  void set_bomb(Bomb bomb_) {
    bomb = bomb_;
    bomb.setPosition(player.getX(), player.getY());
  }
}