class Tile {
  PImage image; // tile graphics
  Boolean canWalk, empty; // can the tile be mined, is it a clear space
  Pickup pickup;
  int tile_type;

  Tile(PImage i, Boolean cw, Boolean e, int tile) {
    image = i;
    canWalk = cw;
    empty = e;
    tile_type = tile;
  }
}