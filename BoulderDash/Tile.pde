class Tile {
  PImage image; // tile graphics
  Boolean canWalk, empty, startingPoint; // can the tile be mined, is it a clear space

  Tile(PImage i, Boolean cw, Boolean e, Boolean sp) {
    image = i;
    canWalk = cw;
    empty = e;  
    startingPoint = sp;
  }
}