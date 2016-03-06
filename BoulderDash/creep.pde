int lastMove = 0;

class Creep {
  int x, y;
  PImage icon;
  Boolean canMine;

  Creep(int x_, int y_, PImage icon_, Boolean canMine_) {
    x = x_;
    y=y_;
    icon = icon_;
    canMine = canMine_;
  }

  void moveRandom() {
    List<Position> positions = new ArrayList<Position>();
    if (x+1 < map.length && (map[x+1][y].empty || canMine))
      positions.add(new Position(x+1, y));
    if (y+1 < map[0].length && (map[x][y+1].empty || canMine))
      positions.add(new Position(x, y+1));
    if (x-1 >= 0 && (map[x-1][y].empty ||canMine))
      positions.add(new Position(x-1, y));
    if (y-1 >= map[0].length-1 && (map[x][y-1].empty || canMine))
      positions.add(new Position(x, y-1));
    if (positions.size() > 0) {
      int i = (int)random(-1, positions.size());
      x = positions.get(i).x;
      y = positions.get(i).y;
      map[x][y].empty = true;
      if (x == player.getGridPosX() && y == player.getGridPosY())
        endGame();
    }
  }

  void draw() {
    image(icon, 32*x, 32*y+8);
  }
}

public class Position {
  public int x, y;
  public Position(int x_, int y_) {
    x = x_;
    y=y_;
  }
}