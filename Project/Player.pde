public class Player implements Displayable {
  float x, y, heading, speed, size, lim, time;
  boolean state, collide;
  int designation, shot;
  public Player(int number) {
    x=100;
    y=100;
    heading=0;
    speed=1;
    state=true;
    designation=number;
    size=20;
    lim = 3;
    time = 0;
    collide = false;
  }

  public void move() {
    x += speed * cos(heading);
    y += speed * sin(heading);
    if (collide) {
      //x += speed * cos(heading);
      //y += speed * sin(heading);
      x = 100;
      y = 100;
    }
    time ++;
  }
  
  public void canMove(float x, float y){
     float p1x = (float)(x + (20 * Math.cos(heading)));
     float p1y = (float)(y + (20 * Math.sin(heading)));
     float p2x = (float)(x + (15 * Math.cos(heading - 90)));
     float p2y = (float)(y + (15 * Math.sin(heading - 90)));
     float p3x = (float)(x + (15 * Math.cos(heading + 90)));
     float p3y = (float)(y + (15 * Math.sin(heading + 90)));
    
     
  }
  
  public float[] ellip(int degrees){
    float[] coord = new float[2];
    float xx = x + 15 * cos(degrees);
    float yy = y + 20 * sin(degrees);
    coord[0] = xx;
    coord[1] = yy;
    return coord;
  }
    

  public boolean state() {
    return state;
  }

  public boolean canShoot() {
    lim --;
    if (lim < -75) {
      lim = 2;
    }
    if (lim + 1 <= 0) {
      return false;
    }
    if (lim + 1 > 0) {
      time =0;
      shot = 1;
      return true;
    }
    return false;
  }

  public void collide(ArrayList<Positionable> others) {
  }

  public void display() {
    fill(255);
    ///rect(x+ (20* cos(heading)),y + (20 *sin(heading)),30 ,20);
    //ellipse(x,y,30,40);
    triangle((float)(x + (20 * Math.cos(heading))), (float)(y + (20 * Math.sin(heading))), 
      (float)(x + (15 * Math.cos(heading - 90))), (float)(y + (15 * Math.sin(heading - 90))), 
      (float)(x + (15 * Math.cos(heading + 90))), (float)(y + (15 * Math.sin(heading + 90))));
  }

  public void setCol(boolean b) {
    collide = b;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
}