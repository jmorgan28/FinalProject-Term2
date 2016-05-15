public Ship[] ships = new Ship[1]; 


void setup(){
  ships[0] = new Ship(true);
  size(1000,800);
}
  

void display(){
  for(int i = 0; i < ships.length; i ++){
    triangle((float)(ships[i].getX() + (30 * Math.cos(ships[i].getOrnt()))), (float)(ships[i].getY() + (30 * Math.sin(ships[i].getOrnt()))),
             (float)(ships[i].getX() + (30 * Math.cos(ships[i].getOrnt() - 90))), (float)(ships[i].getY() + (30 * Math.sin(ships[i].getOrnt() - 90))),
             (float)(ships[i].getX() + (30 * Math.cos(ships[i].getOrnt() + 90))), (float)(ships[i].getY() + (30 * Math.sin(ships[i].getOrnt() + 90))));
  }
}


void input(){
  if (keyPressed && key == 'd'){
    ships[0].increaseOrnt();
  }
  //if (keyPressed && key == 'a'){
    //ships[0].decreaseOrnt();
  //}
}
             
    
  

void draw(){
  background(0,0,0);
  display();
  ships[0].move();
  input();
  
}