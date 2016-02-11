import java.util.HashMap;

Tile[][] map;

void loadMap(String mapPath, String charPath) {
  String[] charLines = loadStrings(charPath);
  HashMap<String, PImage> tiles = new HashMap<String, PImage>();
  for (int i = 0; i < charLines.length; i++) {
    String[] split = split(charLines[i], ' ');
    if (split[1] != "empty")
      tiles.put(split[0], loadImage(split[1]));
    else
      tiles.put(split[0], null);
  }
  String[] mapLines = loadStrings(mapPath);
  println(split(mapLines[0], ' ').length+" "+mapLines.length);
  map = new Tile[split(mapLines[0], ' ').length][mapLines.length];
  for (int y = 0; y < mapLines.length; y++) {
    String[] row = split(mapLines[y], ' ');
    for (int x = 0; x < row.length; x++) {
      map[x][y] = new Tile(tiles.get(row[x]), true, tiles.get(row[x]) == null ? true : false);
    }
  }
}