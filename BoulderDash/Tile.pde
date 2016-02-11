class Tile {
  PImage image; // tile graphics
  Boolean canWalk, empty; // can the tile be mined, is it a clear space

  Tile(PImage i, Boolean cw, Boolean e) {
    image = i;
    canWalk = cw;
    empty = e;  
  }
}