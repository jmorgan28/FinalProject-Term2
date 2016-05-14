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
    x += speed * cos(radians(heading));
    y += speed * sin(radians(heading));
  }
  
  public boolean state() {
    return state;
  }
  
  public void collide(ArrayList<Positionable> others) {
  }

  public void display() {
    fill(255);
    ellipse(x, y, size, size);
  }
}