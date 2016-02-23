class Tile {
  PImage image; // tile graphics
  Boolean canWalk, empty; // can the tile be mined, is it a clear space
  Pickup pickup;
  int tile_type;
  int tile_hp;

  Tile(PImage i, Boolean cw, Boolean e, int tile) {
    image = i;
    canWalk = cw;
    empty = e;
    tile_type = tile;
    if(tile == 1){
     tile_hp = 10; 
    }
    else if(tile == 2){
     tile_hp = 30; 
    }
    else if(tile == 0){
      tile_hp = 2;
    }
  }
  
  void destroy(){
   tile_type = 0;
   empty = true;
   tile_hp = 2;
  }
}