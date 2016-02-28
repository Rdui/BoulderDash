import java.util.HashMap;  //<>//
import java.util.List;

Tile[][] map;
List<Creep> creeps = new ArrayList<Creep>();
int startX; // player start point location
int startY;
int tile_;
PImage bgTile;

void loadMap(String mapPath, String charPath, String pickupPath) {
  bgTile = loadImage("graphics/bg.png");
  HashMap<String, PImage> tiles = new HashMap<String, PImage>();

  String[] charLines = loadStrings(charPath); // map data lines as a string
  for (int i = 0; i < charLines.length; i++) {
    String[] split = split(charLines[i], ' '); 
    if (split.length == 2) 
      tiles.put(split[0], loadImage("graphics/"+split[1]));
    else
      tiles.put(split[0], null);
  }

  String[] mapLines = loadStrings(mapPath);
  map = new Tile[split(mapLines[0], ' ').length][mapLines.length];
  for (int y = 0; y < mapLines.length; y++) {
    String[] row = split(mapLines[y], ' ');
    for (int x = 0; x < row.length; x++) {
      if (row[x].equals("w")) { // tarkistetaan minkätyyppinen tiili on (mitä vaikeampi tiili on rikkoa, sitä suurempi numero sille annetaan.)
        tile_ = 10;
      } else if (row[x].equals("s")) {
        tile_ = 2;
      } else if (row[x].equals("g")) {
        tile_ = 1;
      } else if (row[x].equals("#")) {
        tile_ = 0;
      } else if (row[x].equals("!")) {
        tile_ = 0;
        creeps.add(new Creep(x,y,loadImage("graphics/creep.png")));
      }
      map[x][y] = new Tile(tiles.get(row[x]), true, tiles.get(row[x]) == null ? true : false, tile_);
      if (row[x].equals("@")) {
        startX = x;
        startY = y;
      }
    }
  }

  String[] pickupLines = loadStrings(pickupPath); // pickup data lines as a string
  for (int i = 0; i < pickupLines.length; i++) {
    String[] row = split(pickupLines[i], ' ');
    Pickup pickup = new Pickup(loadImage("graphics/"+row[0]), int(row[1]));
    int j = 2;
    while (true) {
      map[j][j+1].pickup = pickup;
      if (j+2 < row.length)
        j += 2;
      else
        break;
    }
  }
}

void drawMap() {
  for (int y = 0; y < map[0].length; y++) {
    for (int x = 0; x < map.length; x++) {
      Tile tile = map[x][y];
      if (!tile.empty)
        image(map[x][y].image, x*32, y*32+8);
      if (map[x][y].pickup != null)
        image(map[x][y].pickup.icon, x*32, y*32+8);
    }
  }
}

void drawBackground() {
  for (int x = -2; x < 42; x++) {
    for (int y = -2; y < 24; y++) {
      image(bgTile, x*32+player.x/100, y*32+player.y/100);
    }
  }
}