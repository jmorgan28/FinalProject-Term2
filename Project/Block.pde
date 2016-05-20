public class Block implements Displayable{
   public float x,y, l, w;
   boolean state;
   public Block(float x1, float y1, float l1, float l2){
     x = x1;
     y = y1;
     w = l1;
     l = l2;
     state = true;
   }
   
   public boolean amBox(float a, float b){
     return  a >= x && a <= x + w && b <= y && b >= y - l;
   }
   
   public boolean state(){
     return state;
   }
   
   public void display() {
     fill(100);
     rect(x,y,w,l);
   }
     

       
   
}
     