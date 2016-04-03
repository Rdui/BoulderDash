class Boulder {
  PImage image;
  int x, y;
  Boolean canMine;

  Boulder(PImage image_, int x_, int y_, Boolean canMine_) {
    x = x_;
    y = y_;
    image = image_;
    canMine = canMine_;
  }
}