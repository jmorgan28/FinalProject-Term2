public class Player implements Displayable {
  float x, y, heading, speed, size, lim, time;
  boolean state, collide, hasLazer;
  int designation, shot, hp;
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
    hp = 2;
    collide = false;
    hasLazer = false;
  }

  public void move() {
    if (hp == 1) {
      x += (speed * .4) * cos(heading);
      y += (speed * .4) * sin(heading);
      if (collide) {
        x -= ((speed *.4)+4) * cos(heading);
        y -= ((speed *.4) + 4) * sin(heading);
        //x = 100;
        //y = 100;
      }
    } else {
      x += speed * cos(heading);
      y += speed * sin(heading);
      if (collide) {
        x -= (speed +4) * cos(heading);
        y -= (speed + 4) * sin(heading);
        //x = 100;
        //y = 100;
      }
      time ++;
    }
  }

  public void canMove(float x, float y) {
    float p1x = (float)(x + (20 * Math.cos(heading)));
    float p1y = (float)(y + (20 * Math.sin(heading)));
    float p2x = (float)(x + (15 * Math.cos(heading - 90)));
    float p2y = (float)(y + (15 * Math.sin(heading - 90)));
    float p3x = (float)(x + (15 * Math.cos(heading + 90)));
    float p3y = (float)(y + (15 * Math.sin(heading + 90)));
  }

  public float[] ellip(int degrees) {
    float[] coord = new float[2];
    float xx = x + 10 * cos(degrees);
    float yy = y + 15 * sin(degrees);
    coord[0] = xx;
    coord[1] = yy;
    return coord;
  }


  public boolean state() {
    return state;
  }

  public boolean canShoot() {
    if (hp != 1) { // need to fix lazer
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
    return false;
  }

  public void collide(ArrayList<Positionable> others) {
  }

  public void display() {
    if (hp == 1) {
      fill(255);
      ellipse(x, y, 9, 9);
    } else {
      if (! hasLazer) {
        noStroke();
      }
      fill(255);
      ///rect(x+ (20* cos(heading)),y + (20 *sin(heading)),30 ,20);
      //ellipse(x,y,20,30);
      triangle((float)(x + (20 * Math.cos(heading))), (float)(y + (20 * Math.sin(heading))), 
        (float)(x + (15 * Math.cos(heading - 90))), (float)(y + (15 * Math.sin(heading - 90))), 
        (float)(x + (15 * Math.cos(heading + 90))), (float)(y + (15 * Math.sin(heading + 90))));
    }
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

  public boolean amDead() {
    return hp <= 0;
  }


  public boolean inTriangle(float xxx, float yyy) {
    float y1 = (float)(y + (20 * Math.sin(heading)));
    float x1 = (float)(x + (20 * Math.cos(heading)));
    float y2 = (float)(y + (15 * Math.sin(heading - 90)));
    float x2 = (float)(x + (15 * Math.cos(heading - 90)));
    float y3 = (float)(y + (15 * Math.sin(heading + 90)));
    float x3 = (float)(x + (15 * Math.cos(heading + 90)));
    float a = ((y2 - y3)*(xxx - x3) + (x3 - x2)*(yyy - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
    float b = ((y3 - y1)*(xxx - x3) + (x1 - x3)*(yyy - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
    float c =  1 - a - b;
    return  0 <= a && a <= 1 && 0 <= b && b <= 1 && 0 <= c && c <= 1;
  }
}