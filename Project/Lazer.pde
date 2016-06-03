public class Lazer implements Displayable {
  //public boolean isDrop, isHeld;
  public float x, y, heading, xx1, xx2, yy1, yy2, slope;
 
  boolean state;




  public Lazer(float x1, float y1, float h1) {
    x = x1;
    y = y1;
    heading = h1;
    xx1 = (float)(x + (21 * Math.cos(heading)));
    yy1 = (float)(y + (21 * Math.sin(heading)));
    xx2 = (float)(x + (300 * Math.cos(heading)));
    yy2 = (float)(y + (300 * Math.sin(heading)));
    slope = (yy1 - yy2) / (xx1 - xx2);
    //isDrop = false;
    //isHeld = true;
    state = true;
  }

  public boolean state() {
    return state;
  }

  // public boolean amLazer(float a, float b) {
  // return 
  //}


  public void display() {
    stroke(0, 0, 255);
    line((float)(x + (40 * Math.cos(heading))), (float)(y + (40 * Math.sin(heading))), (float)(x + (300 * Math.cos(heading))), (float)(y + (300 * Math.sin(heading))));
  }
}