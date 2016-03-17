class Flame {
  PImage image;
  int x, y;
  int flameTimer;

  Flame(PImage image_, int x_, int y_, int delay) {
    x = x_;
    y = y_;
    image = image_;
    flameTimer = millis()+delay*100;
  }
}