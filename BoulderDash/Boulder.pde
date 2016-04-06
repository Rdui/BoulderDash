class Boulder {
  PImage image;
  int x, y;
  Boolean canMine;
  Boolean hasMomentum = false;

  Boulder(PImage image_, int x_, int y_, Boolean canMine_, Boolean hasMomentum_) {
    x = x_;
    y = y_;
    image = image_;
    canMine = canMine_;
    hasMomentum = hasMomentum_;
  }
}