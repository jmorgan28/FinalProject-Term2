public class Warp implements Displayable {
  public float x, y, diameter;
  private int c;
  boolean state = true;
  public Warp(float x1, float y1, float r, int col) {
    x = x1;
    y = y1;
    diameter = r;
    c = col;
  }


  public boolean amWarp(float a, float b) {
    return  a >= x - diameter/2 && a <= x + diameter /2 && b >= y - diameter/2 && b <= y + diameter /2;
  }

  public void display() {
    fill(c);
    ellipse(x, y, diameter, diameter);
  }

  public boolean state() {
    return state;
  }
}