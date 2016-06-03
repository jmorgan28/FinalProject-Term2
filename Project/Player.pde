public class Player implements Displayable {
  float x, y, heading, speed, size, lim, time;
  boolean state, collide, hasLazer, boost;
  int designation, shot, hp, ifg, hptime;
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
    hptime = 0;
    hp = 2;
    collide = false;
    hasLazer = false;
    boost = false;
    ifg = 0;
  }
  //// merge merge merge
  /*public boolean move() {
   System.out.println(heading);
   time ++;
   ifg = 0;
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
   y+= speed * sin(heading);
   if (collide) {
   if ((x >= 20 && x <= 580 && y <= 37 ) || (x >= 20 && x <= 580 && y >= 373) ) {
   y -= speed * sin(heading);
   ifg =1;
   return true;
   }
   if ((y >= 20 && y <=380 && x <=37) || (y >= 20 && y <=380 && x >=577)) {
   x -= speed * cos(heading);
   ifg = 2;
   return true;
   } else {
   x -= (speed +4) * cos(heading);
   y -= (speed +4) * sin(heading);
   return true;
   }
   //x = 100;
   //y = 100;
   }
   }
   return true;
   }
   */

  public boolean move() {
    if (y < 20) {
      y += (speed + 9) * sin(heading);
      collide = false;
    }
    if (y > 380) {
      y += (speed + 9) * sin(heading);
      collide = false;
    }
    if (x < 20) {
      x += (speed + 9) * cos(heading);
      collide = false;
    }
    if (x > 580) {
      x += (speed + 9) * cos(heading);
      collide = false;
    }

    if (x <0 || y <0 || x >600 || y > 400) {
      x= 50;
      y = 50;
    }
    //System.out.println(sin(heading));
    // println(collide);
    time ++;
    if (hp == 1) {
      hptime ++;
    }
    if (hptime >= 550) {
      hptime = 0;
      hp = 2;
    }
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
      if (! collide) {
        if (boost) {
          x += (speed+ 5) * cos(heading);
          y += (speed + 5) * sin(heading);
        } else {
          x += speed * cos(heading);
          y+= speed * sin(heading);
         
        }
         ifg = 0;
      }

      if (collide) {
        if ((x >= 25 && x <= 575 && y <= 37 && (sin(heading) <= 0 && cos(heading) >= -1)) || (x >= 25 && x <= 575 && y >= 373 && (sin(heading) >= 0 && cos(heading) <= 1)) ) {
          y -= speed * sin(heading);
          ifg =1;
          return true;
        }
        if ((y >= 25 && y <=385 && x <=37 && (sin(heading) >= -1 && cos(heading) <= 0)) || (y >= 25 && y <=385 && x >=565 && (sin(heading) <= 1 && cos(heading) >= 0))) {
          x -= speed * cos(heading);
          ifg = 1;
          return true;
        } else {
          if (ifg == 0) {
            x -= (speed +4) * cos(heading);
            y -= (speed +4) * sin(heading);
            return true;
          } else {
            x += (speed+ 5) * cos(heading);
            y += (speed + 5) * sin(heading);
            return true;
          }
        }


        //x = 100;
        //y = 100;
      }
    }
    return true;
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
    float xx = x + 7 * cos(degrees);
    float yy = y + 7 * sin(degrees);
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
      if (lim < -30) {
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
    if (hp <= 1) {
      fill(255);
      ellipse(x, y, 9, 9);
    } else {
      if (! hasLazer) {
        noStroke();
      }
      fill(255);
      ///rect(x+ (20* cos(heading)),y + (20 *sin(heading)),30 ,20);
      //ellipse(x, y, 14, 14);
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