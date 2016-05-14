public class Ship{
  //some of these variables may not be needed
  private double x, y, orientation;
  private boolean isDead, Player;
  private int ammoLimit, hp;
  
  
  public Ship(boolean isPlayer){
    x = 0;
    y = 0;
    hp = 2;
    orientation = 0;
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
  
  public double getOrnt(){
    return orientation;
  }
  
  
  public boolean isDead(){
    return isDead;
  }
  
   public boolean isPlayer(){
    return Player;
  }
  
  public void setDead(boolean dead){
    isDead = dead;
  }
  
  public void takeDamage(){
     hp --;
  }
  
  public void increaseOrnt(){
    orientation ++;
    if(orientation == 360){
      orientation = 0;
    }
  }
  
  public void decreaseOrnt(){
    orientation --;
    if(orientation == 0){
      orientation = 360;
    }
  }
  
  public void move(){
    x += Math.cos(orientation);
    y += Math.sin(orientation);
  }
    
     
  
  
  
}
  