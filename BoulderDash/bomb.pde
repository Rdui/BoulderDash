class Bomb extends AbstractItem {
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

  void Use(AbstractItem item) {
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

  // calls the righ shape constructor
  void explode() {
    player.bombsLeft++;
    if (shape == 0)
      plusExplosion();
  }
  // radius increases plus length
  void plusExplosion() {
    flames.add(new Flame(loadImage("graphics/explosionmiddle.png"), x, y, 15));
    for (int fx = (x-radius > -1 ? -radius : -x); fx <= radius; fx++) {
      if ( x+fx > 39 || x+fx <= 0 || map[x+fx][y].tileHp == -1 ){
        continue;
      }
      if (map[x+fx][y].item != null) {
        pickups.add(map[x+fx][y].item);
        map[x+fx][y].item.x = x+fx;
        map[x+fx][y].item.y =y;
      }
      
      map[x+fx][y].destroy();      
      flames.add(new Flame(loadImage("graphics/explosionhorizontal.png"), x+fx, y, 15));
    }
    for (int fy = (y-radius > -1 ? -radius : -y); fy <= radius; fy++) {
      if ( y+fy > 21 || y+fy <= 0 || map[x][y+fy].tileHp == -1 ){
        continue;
      }
      flames.add(new Flame(loadImage("graphics/explosionvertical.png"), x, y+fy, 15));
      if (map[x][y+fy].item != null) {
        pickups.add(map[x][y+fy].item);
        map[x][y+fy].item.x = x;
        map[x][y+fy].item.y =y+fy;
      }
      map[x][y+fy].destroy();
    }
  }
}