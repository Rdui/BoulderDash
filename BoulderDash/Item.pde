abstract class Item {
  int score = 0;
  PImage icon;
  Boolean visible = false; // visible in inventory
  
  Item(PImage i, int s, Boolean v) {
    icon = i;
    score = s;
    visible = v;
  }
  
  abstract void Use(Item item);
}