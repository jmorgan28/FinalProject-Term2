public class Block implements Displayable {
  public float x, y, l, w;
  private int c;
  boolean state, boost;
  public Block(float x1, float y1, float l1, float l2, int col, boolean k) {
    x = x1;
    y = y1;
    w = l1;
    l = l2;
    state = true;
    c = col;
    boost = k;
  }

  public boolean amBox(float a, float b) {
    return  a >= x && a <= x + w && b >= y && b <= y + l;
  }

  public boolean state() {
    return state;
  }

  public void display() {
    if (! boost) {
      fill(c);
    } else {
      fill(255, 255, 0);
    }
    rect(x, y, w, l);
  }
}