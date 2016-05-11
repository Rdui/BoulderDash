import java.util.HashMap;  //<>// //<>// //<>//
import java.util.List;

Tile[][] map; // the actual map
List<Creep> creeps = new ArrayList<Creep>();
List<Bomb> bombs = new ArrayList<Bomb>();
List<Flame> flames = new ArrayList<Flame>();
List<AbstractItem> pickups = new ArrayList<AbstractItem>(); // items that can be picked up by walking over them
List<Boulder> boulders = new ArrayList<Boulder>();
int startX; // player start point location
int startY;
int tile_;
PImage bgTile, keyicon, portalicon, closedportalicon;
Tile groundTile, emptyTile;

void loadMap(String mapPath, String charPath) {
  player.reset();
  bgTile = loadImage("graphics/bg.png");
  keyicon = loadImage("graphics/key.png");
  portalicon = loadImage("graphics/portal.png");
  closedportalicon = loadImage("graphics/closedportal.png");
  HashMap<String, Tile> tiles = new HashMap<String, Tile>();

  // 
  String[] charLines = loadStrings(charPath); // map data lines as a string
  for (int i = 0; i < charLines.length; i++) {
    String[] split = split(charLines[i], ' '); 
    Tile tile;
    switch(split[0]) {
    case "tile":
      tiles.put(split[1], new Tile(loadImage("graphics/"+split[2]), false, false, int(split[3])));
      break;
    case "empty":
      tile = new Tile(createImage(32, 32, ARGB), true, true, 2);
      emptyTile = tile;
      tiles.put(split[1], emptyTile);
      break;
    case "ground":
      tile = new Tile(loadImage("graphics/"+split[2]), false, false, int(split[3]));
      groundTile = tile;
      tiles.put(split[1], tile);
      break;
    case "bomb":
      tile = new Tile(groundTile);
      tile.item =  new Bomb(loadImage("graphics/"+split[2]), int(split[3]), int(split[4]), int(split[5]), split[6]+" "+split[7]); 
      tiles.put(split[1], tile);
      break;
    case "portal":
      tile = new Tile(groundTile);
      tile.portal = true;
      tiles.put(split[1], tile);
      break;
    case "portalkey":
      tile = new Tile(groundTile);
      tile.portalkey = true;
      tiles.put(split[1], tile);
      break;
    case "score":
      tile = new Tile(groundTile);
      tile.item = new Coin(loadImage("graphics/"+split[2]), int(split[3]), split[4]);
      tiles.put(split[1], tile);
      break;
    }
  }

  String[] mapLines = loadStrings(mapPath);
  map = new Tile[split(mapLines[0], ' ').length][mapLines.length];
  for (int y = 0; y < mapLines.length; y++) {
    String[] row = split(mapLines[y], ' ');
    for (int x = 0; x < row.length; x++) 
    {
      if (row[x].equals("!")) { // normal creep
        map[x][y] = new Tile(emptyTile);
        creeps.add(new Creep(x, y, loadImage("graphics/creep.png"), false));
      } else if (row[x].equals("?"))
      {
        map[x][y] = new Tile(emptyTile); // mining creep
        creeps.add(new Creep(x, y, loadImage("graphics/worm.png"), true));
      } else if (row[x].equals("+"))
      {
        map[x][y] = new Tile(emptyTile); // suicide creep
        Creep creep = new Creep(x, y, loadImage("graphics/bombcreep.png"), false);
        creep.suicide = true;
        creeps.add(creep);
      } else if (row[x].equals("@")) {
        startX = x;
        startY = y;
        player.setCoordinates(startX*32, startY*32+8);
        map[x][y] = new Tile(emptyTile);
      } else if (row[x].equals("b")) {
        map[x][y] = new Tile(emptyTile);
        boulders.add(new Boulder(loadImage("graphics/boulder.png"), x, y, true, false)); /// adds boulders to the boulders array that is used in processBoulders function
      } else {
        map[x][y] = new Tile(tiles.get(row[x]));
      }
    }
  }
}

// draw map tiles and items
void drawMap() {
  for (int y = 0; y < map[0].length; y++) {
    for (int x = 0; x < map.length; x++) {
      Tile tile = map[x][y];
      if (!tile.empty) {
        image(map[x][y].image, x*32, y*32+8);
      } else if (tile.portalkey) { // portal keys on empty tiles
        image(keyicon, x*32, y*32+8);
      } else if (tile.item != null)
        image(tile.item.icon, x*32, y*32+8);
      if (tile.portal)
        if (player.keys == 3)
          image(portalicon, x*32, y*32+8);
        else
          image(closedportalicon, x*32, y*32+8);
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