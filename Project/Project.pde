import processing.net.*;

public interface Positionable {
  public boolean state();
}
public interface Displayable extends Positionable {
  public void display();
}

public interface Moveable extends Positionable {
  public void move(); 
  public void collide(ArrayList<Positionable> others);
}


ArrayList<Moveable> moveables = new ArrayList<Moveable>();
ArrayList<Displayable> displayables = new ArrayList<Displayable>();
ArrayList<Positionable> positionables = new ArrayList<Positionable>();
ArrayList<Player> players = new ArrayList<Player>();

int playerCount=1;
int myPlayer=0;

boolean aDown, dDown;

Server server;
Client client;

public void setup() {
  size(600, 400);
  if (myPlayer == 0) { 
    server=new Server(this, 6666);
  }
  else{
    client=new Client(this, "127.0.0.1", 6666);
  }
  for (int i = 0; i < playerCount; i++) {
    Player p = new Player(i);
    displayables.add(p);
    positionables.add(p);
    players.add(p);
  }
}

public void keyPressed() {
  if (key=='a') {
    aDown=true;
  }
  if (key=='d') { 
    dDown=true;
  }
}
public void keyReleased() {
  if (key=='a') {
    aDown=false;
  }
  if (key=='d') { 
    dDown=false;
  }
}

public void delete(float x, float y) {
}

public void send(){
  for (Player p : players) {
    if (p.designation==myPlayer) {
      server.write("" + p.x+ "," + p.y + "," + p.heading);
    }
  }
}

public void read(){
  String line = "wow";
 
  Client playa=server.available();
        if (playa !=null) {
          line = playa.readString();
        }
       System.out.println(line);

}
  



public void draw() {
  background(0);
 send();
 //read();
  for (Player p : players) {
    if (p.designation==myPlayer) {
      p.move();
      if (dDown) {
        p.heading+=.05;
      }
      if (aDown) {
        if(p.canShoot()){
        Bullet b = new Bullet(p.x, p.y, p.heading);
        displayables.add(b);
        positionables.add(b);
        moveables.add(b);
        }
      }
    } else {
      String info;
      if (myPlayer==0) {
        Client player=server.available();
        if (player !=null) {
          info = player.readString();
          if (info != null) {
            server.write(info);
            
          }
        }
      }
      else{
        info = client.readString();
        
      }
    }
  }
  if(myPlayer!=0){
    client.clear();
  }

  for ( Moveable m : moveables) {
    m.move();
    m.collide(positionables);
  }

  for ( Displayable d : displayables) {
    d.display();
  }

  for (int i = moveables.size() - 1; i >= 0; i--) {
    if (!moveables.get(i).state()) {
      moveables.remove(i);
    }
  }

  for (int i = displayables.size() - 1; i >= 0; i--) {
    if (!displayables.get(i).state()) {
      displayables.remove(i);
    }
  }

  for (int i = positionables.size() - 1; i >= 0; i--) {
    if (!positionables.get(i).state()) {
      positionables.remove(i);
    }
  }
}