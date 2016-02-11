class Tile {
  PImage image;
  Boolean canWalk, empty; // can the tile be mined, is it a clear space

  Tile(PImage i, Boolean b, Boolean e) {
    image = i;
    canWalk = b;
    empty = e;
  }
}