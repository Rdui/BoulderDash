import java.util.HashMap;  //<>// //<>//
import java.util.List;

Tile[][] map;
List<Creep> creeps = new ArrayList<Creep>();
List<Bomb> bombs = new ArrayList<Bomb>();
List<Flame> flames = new ArrayList<Flame>();
int startX; // player start point location
int startY;
int tile_;
PImage bgTile;
Tile groundTile;

void loadMap(String mapPath, String charPath) {
  bgTile = loadImage("graphics/bg.png");
  HashMap<String, Tile> tiles = new HashMap<String, Tile>();

  String[] charLines = loadStrings(charPath); // map data lines as a string
  for (int i = 0; i < charLines.length; i++) {
    String[] split = split(charLines[i], ' '); 
    switch(split[0]) {
    case "tile":
      tiles.put(split[1], new Tile(loadImage("graphics/"+split[2]), false, false, int(split[3])));
      break;
    case "empty":
      tiles.put(split[1], new Tile(null, true, true, 2));
      break;
    case "ground":
      tiles.put(split[1], new Tile(loadImage("graphics/"+split[2]), true, true, int(split[3])));
    case "bomb":
      Tile tile = groundTile;
      tile.item =  new Bomb(loadImage(split[2]), int(split[3]), int(split[4])); 
      tiles.put(split[1], tile);
      break;
    }
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
        creeps.add(new Creep(x, y, loadImage("graphics/creep.png"), false));
      } else if (row[x].equals("?")) {
        tile_ = 0;
        creeps.add(new Creep(x, y, loadImage("graphics/worm.png"), true));
      }
      map[x][y] = tiles.get(row[x]);
      if (row[x].equals("@")) {
        startX = x;
        startY = y;
      }
    }
  }
}

void drawMap() {
  for (int y = 0; y < map[0].length; y++) {
    for (int x = 0; x < map.length; x++) {
      Tile tile = map[x][y];
      if (!tile.empty)
        image(map[x][y].image, x*32, y*32+8);
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