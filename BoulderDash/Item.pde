class Pickup {
  int score = 0;
  PImage icon;
  Pickup(PImage i, int s) {
    icon = i;
    score = s;
  }
}

class Inventory {
  int item = 0;
  
  void rotation() {
    if (rotateleft == 1) {
      --item;
      println(item);
    }
    if (rotateright == 1) {
      ++item;
      
      println(item);
    }
  }
  
}