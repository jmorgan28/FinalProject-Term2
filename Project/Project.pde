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

boolean aDown, dDown, menu, amServer, amClient;

Server server;
Client client;

public void setup() {
  size(600, 400);

  displayables.add(new Block(0, 0, 30, 30));
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

public void send(Player p) {
  //we need some sort of int like didShoot and gotShot in player to send along with this stuff
  server.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+",");
}

public String read() {
  String line = "";

  Client player=server.available();
  if (player !=null) {
    line = player.readString();
  }
  return line;
}




public void draw() {
  background(0);
  if (menu) {
    // menu needs buttons that have you select if starting game(server) or joining(client) and something to specify the number of players that will be/are in the game
    if (amServer) {
      myPlayer = 0;
      server=new Server(this, 6666); 
      menu=false;
    }
    if (amClient) {
      client=new Client(this, "127.0.0.1", 6666);
      myPlayer=(int)random(10^10)+1;
      menu=false;
    }
    if (!menu) {
      for (int i = 0; i < playerCount; i++) {
        Player p = new Player(i);
        displayables.add(p);
        positionables.add(p);
        players.add(p);
      }
    }
  } else {

    for (Player p : players) {
      if (p.designation==myPlayer) {
        p.move();
        if (dDown) {
          p.heading+=.05;
        }
        if (aDown) {
          if (p.time > 15 && p.canShoot() ) {
            Bullet b = new Bullet((float)(p.x + (30 * Math.cos(p.heading))), (float)(p.y + (30 * Math.sin(p.heading))), p.heading);
            displayables.add(b);
            positionables.add(b);
            moveables.add(b);
          }
        }
        send(p);
      } else {
        String info;
        if (myPlayer==0) {
          info=read();
          if (info != "") {
            server.write(info);
            //info is ALL client messages from ONE client that have not yet been read in string form; do string stuff here
          }
        } else {
          info = client.readString();
          //info is string containing EVERY message the server has sent to this client and has not yet been cleared in string form; do string stuff here
        }
      }
    }
    if (myPlayer!=0) {
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
}