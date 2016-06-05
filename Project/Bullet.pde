public class Bullet implements Moveable, Displayable {
  float x, y, heading, speed, size;
  boolean state;
  public Bullet(float pX, float pY, float direction) {
    x = pX;
    y = pY;
    heading = direction;
    speed = 2; //2
    size=3;
    state=true;
  }

  public boolean state() {
    return state;
  }
  public boolean setState(boolean b) {
    return state=b;
  }

  public void move() {
    x += speed * cos((heading)); 
    y += speed * sin((heading));
  }

  public void collide(ArrayList<Positionable> others) {
  }

  public void display() {
    fill(255);
    ellipse(x, y, size, size);
  }
}