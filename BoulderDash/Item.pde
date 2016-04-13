// template for items and bombs
abstract class AbstractItem {
  int x,y;
  int score = 0;
  PImage icon;
  Boolean visible = false; // visible in inventory
  String itemName;
  int thisBombLeft = 1;
  
  AbstractItem(PImage i, int s, Boolean v, String n) {
    icon = i;
    score = s;
    visible = v;
    itemName = n;
  }
  
  abstract void Use(AbstractItem item);
}