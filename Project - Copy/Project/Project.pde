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
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Warp> warp = new ArrayList<Warp>();
PFont c, s;



int playerCount=0;
int myPlayer=0;

boolean aDown, dDown, menu, amServer, amClient;

Server server;
Client client;

public void setup() {
  size(600, 400);
  c = createFont("Arial", 16, true);
  s = createFont("Arial", 16, true);
  menu = true;
  amServer=false;
  amClient = false;
  displayables.add(new Block(0, 0, 20, 400, 100));
  displayables.add(new Block(580, 0, 20, 400, 100));
  displayables.add(new Block(20, 0, 560, 20, 100));
  displayables.add(new Block(20, 380, 560, 20, 100));
  displayables.add(new Block(300, 200, 20, 20, 100));
  for (int i = 0; i < displayables.size(); i ++) {
    blocks.add((Block)(displayables.get(i)));
  }
  Warp w = new Warp(80, 50, 13, 150); 
  displayables.add(w);
  warp.add(w);
}

public void keyPressed() {
  if (key=='a') {
    aDown=true;
  }
  if (key=='d') { 
    dDown=true;
  }
}

public void makeMenu(){
 background(255,0,0); 
 textFont(c, 36);
 fill(255);
 text("Join as Server", 0, 150);
 textFont(s, 36);
 fill(255);
 text("Join as Client", 0, 300);
 if(mousePressed){
   if(mouseX >= 0 && mouseX <= 250 && mouseY<= 150 && mouseY>= 100){
     amServer = true;
     playerCount ++;
   }
   else{if(mouseX >= 0 && mouseX <= 250 && mouseY<= 300 && mouseY>= 250){
     amClient = true;
     playerCount ++;
   }
   }
     
 }
   

  
}

public void collision() {
  for (int i = 0; i < moveables.size(); i ++) {
    for (int k = 0; k < blocks.size(); k ++) { 
      if (moveables.get(i) instanceof Bullet) {
        Bullet temp = (Bullet) moveables.get(i);
        if (blocks.get(k).amBox(temp.x, temp.y)) { 
          displayables.remove(temp);
          positionables.remove(temp);
          moveables.remove(temp);
          k = blocks.size();
          i --;
        }
      } else {
        if (moveables.get(i) instanceof Player) {
          Player tmp = (Player) moveables.get(i);
          if (blocks.get(k).amBox(tmp.x, tmp.y)) { // this has to be made to check for all tips of triangle 
            tmp.setCol(true); // this nees to do something to hold back or turn triangle
          } else {
            tmp.setCol(false);
          }
        }
      }
    }
  }
}

public void warped() { // too be made accurate later
  for (int i = 0; i < moveables.size(); i ++) {
    for (int k = 0; k < warp.size(); k ++) { 
      if (moveables.get(i) instanceof Bullet) {
        Bullet temp = (Bullet) moveables.get(i);
        if (warp.get(k).amWarp(temp.x, temp.y)) {
          if (temp.heading + 180 > 360) {
            temp.heading = 0 + (temp.heading + 180 - 360);
          } else {
            temp.heading += 180;
          }
        }
      }
    }
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
  try {
    if (amServer) { 
      server.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," + p.shot+","  + playerCount + "," );
    } else {
      client.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," + p.shot+","  + playerCount + "," );
    }
    p.shot = 0;
  }
  catch(Exception e) {
    send(p);
  }
  //we need some sort of int like didShoot and gotShot in player to send along with this stuffddddddddd
}

public void read() {
  try {
    String line="";
    if (amServer) {
      Client player=server.available();
      if (player !=null) {
        line = player.readString();
      }
      if (!line.equals("")) {
        server.write(line);
      }
    } else {
      line = client.readString();
    }
    parse(line);
  }
  catch(Exception e) {
    read();
  }
}
private boolean nullCheck(String s) {
  if (s.indexOf(",")==-1) {
    return true;
  }
  return false;
}
public void parse(String s) {
  if (nullCheck(s)) {
    return;
  }
  String designation = s.substring(0, s.indexOf(","));
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)) {
    return;
  }
  String x = s.substring(0, s.indexOf(","));
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)) {
    return;
  }
  String y = s.substring(0, s.indexOf(","));
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)) {
    return;
  }
  String heading = s.substring(0, s.indexOf(","));
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return;
  }
  String sh = s.substring(0, s.indexOf(","));
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return;
  }
  int play = (int)Float.parseFloat(s.substring(0, s.indexOf(",")));
  int shot = (int)Float.parseFloat(sh);
  float xVal = Float.parseFloat(x);
  float yVal = Float.parseFloat(y);
  float hea = Float.parseFloat(heading);
  int des =(int) Float.parseFloat(designation);
  if (players.size() < des) {
    Player p = new Player(des);
    p.x = xVal;
    p.y= yVal;
    p.heading = hea;
    //playerCount = play;
    displayables.add(p);
    positionables.add(p);
    players.add(p);
  } else {
    players.get(des).x = xVal;
    players.get(des).y = yVal;
    players.get(des).heading = hea;
  }
  if (shot==1) {
    Bullet b = new Bullet((float)(xVal + (30 * Math.cos(hea))), (float)(yVal + (30 * Math.sin(hea))), hea);
    displayables.add(b);
    positionables.add(b);
    moveables.add(b);
  }
}

public void playerMovement() {
  try {
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
        collision();
        warped();
        send(p);
      } else {
        read();
      }
    }
  }
  catch(Exception e) {
    playerMovement();
  }
}


public void draw() {
  background(0);
  if (menu) { 
    makeMenu();
    // menu needs buttons that have you select if starting game(server) or joining(client) and something to specify the number of players that will be/are in the game
    if (amServer) {
      myPlayer = 0;
      server=new Server(this, 6666, "127.0.0.1" ); 
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

    playerMovement();

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