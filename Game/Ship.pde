public class Ship{
  //some of these variables may not be needed
  private double x, y;
  private boolean isDead, Player;
  private int ammoLimit;
  
  
  public Ship(boolean isPlayer){
    x = 0;
    y = 0;
    isDead = false;
    Player = isPlayer;
    ammoLimit = 3; //placeholder 
  }
  
  
  public double getX(){
    return x;
  }
  
  public double getY(){
    return y;
  }
  
  public boolean isDead(){
    return isDead;
  }
  
   public boolean isPlayer(){
    return Player;
  }
    
     
  
  
  
}
  