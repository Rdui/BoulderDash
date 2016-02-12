float up = 0;
float down = 0;
float left = 0;
float right = 0;

void movementKeyPressed(){
  if(key == 'w'){
      up = 1;
  }
  else if(key == 's'){
     down = 1;
  }
  else if(key == 'a'){
     left = 1;
  }
  else if(key == 'd'){
     right = 1;
  }
}

void movementKeyReleased(){
  if(key == 'w'){
      up = 0;
  }
  else if(key == 's'){
     down = 0;
  }
  else if(key == 'a'){
     left = 0;
  }
  else if(key == 'd'){
     right = 0;
  }
}