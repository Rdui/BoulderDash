import java.util.Random;

int lastMove = 0;

class Creep {
  int x, y;
  PImage icon;

  Creep(int x_, int y_, PImage icon_) {
    x = x_;
    y=y_;
    icon = icon_;
  }

  void moveRandom() {
    Random random = new Random();
    if (random.nextInt(2) == 1) {
      int randX = random.nextInt(2)*random.nextInt(2)==1?1:-1;
      if (x+randX > 0 && x+randX < map.length)
        x += randX;
    } else {
      int randY = random.nextInt(2)*random.nextInt(2)==1?1:-1;
      if (y+randY > 0 && y+randY < map[0].length)
        y += randY;
    }
  }

  void draw() {
    image(icon, 32*x, 32*y);
  }
}