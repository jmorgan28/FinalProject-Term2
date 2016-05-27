public class LazerDrop implements Displayable {
  //public boolean isDrop, isHeld;
  public int x, y;
  boolean state;


  public LazerDrop(int x1, int y1) {
    x = x1;
    y = y1;
    //isDrop = false;
    //isHeld = true;
    state = true;
  }
  
  public boolean state() {
    return state;
  }
  
  public boolean amLazer(float a, float b) {
    return  a >= x && a <= x + 15 && b >= y && b <= y + 15;
  }


  public void display() {
    fill(0, 0, 255);
    rect(x, y, 15, 15);
  }
}