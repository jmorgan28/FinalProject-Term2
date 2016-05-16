public class Player implements Displayable {
  float x, y, heading, speed, size;
  boolean state;
  int designation;
  public Player(int number) {
    x=100;
    y=100;
    heading=0;
    speed=1;
    state=true;
    designation=number;
    size=20;
  }

  public void move() {
    x += speed * cos(heading);
    y += speed * sin(heading);
  }
  
  public boolean state() {
    return state;
  }
  
  public void collide(ArrayList<Positionable> others) {
  }

  public void display() {
    fill(255);
        triangle((float)(x + (30 * Math.cos(heading))), (float)(y + (30 * Math.sin(heading))),
             (float)(x + (30 * Math.cos(heading - 90))), (float)(y + (30 * Math.sin(heading - 90))),
             (float)(x + (30 * Math.cos(heading + 90))), (float)(y + (30 * Math.sin(heading + 90))));
  }
}