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
      x += speed * cos(heading);
      y += speed * sin(heading);
    }
    time ++;
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