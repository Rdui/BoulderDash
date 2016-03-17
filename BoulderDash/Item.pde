// template for items and bombs
abstract class Item {
  int score = 0;
  PImage icon;
  Boolean visible = false; // visible in inventory
  String itemName;
  
  Item(PImage i, int s, Boolean v, String n) {
    icon = i;
    score = s;
    visible = v;
    itemName = n;
  }
  
  abstract void Use(Item item);
}