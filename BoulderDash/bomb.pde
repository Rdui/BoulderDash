class Bomb extends Item {
  Tile tile; // reference to tile the bomb is on
  int delay; // bomb time in s
  int bomb_type;
  int radius;
  int shape;
  int x;
  int y;
  int bombTimer = 0;
  Boolean explosive = false; // is this instance supposed to explode

  Bomb(PImage icon_, int radius_, int shape_, int delay_, String name) {
    super(icon_, 0, true, name);
    radius = radius_;
    shape = shape_;
    delay = delay_;
  }

  Bomb(Bomb another) {
    super(another.icon, another.score, true, another.itemName);
    radius = another.radius;
    shape = another.shape;
    delay = another.delay;
  }

  void Use(Item item) {
    if (player.bombsLeft > 0) {
      Bomb bomb = new Bomb((Bomb)item);
      bomb.setPosition(player.getX(), player.getY());
      bombs.add(bomb);
      bomb.bombTimer = millis()+delay*1000;
      bomb.explosive = true;
      player.bombsLeft--;
    }
  }

  void setPosition(int x_, int y_) {
    x = x_;
    y = y_;
  }

  // clears breakable things from the exploding bombs blast radius
  void explode() {
    player.bombsLeft++;
    if (shape == 0)
      plusExplosion();
  }

  void plusExplosion() {
    flames.add(new Flame(loadImage("graphics/explosionmiddle.png"), x, y, 15));
    for (int fx = -radius; fx <= radius; fx++)
      flames.add(new Flame(loadImage("graphics/explosionhorizontal.png"), x+fx, y, 15));
    for (int fy = -radius; fy <= radius; fy++)
      flames.add(new Flame(loadImage("graphics/explosionvertical.png"), x, y+fy, 15));
  }
}