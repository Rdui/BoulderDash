class Coin extends AbstractItem {
  Tile tile; // reference to tile the bomb is on
  int x;
  int y;

  Coin(PImage icon, int _score, String name) {
    super(icon, 0, true, name);
    this.score = _score;
  }

  Coin(Coin another) {
    super(another.icon, another.score, true, another.itemName);
    this.score = another.score;
  }
  
  void Use(AbstractItem item){}
}