import processing.net.*; //<>//

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
ArrayList<Block> blocks= new ArrayList<Block>();
ArrayList<Warp> warp = new ArrayList<Warp>();
PFont c, s, n;



int playerCount=0;
int myPlayer=0;
int lazerTime = 0;

boolean aDown, dDown, menu, amServer, amClient;

Server server;
Client client;

public void setup() {
  size(600, 400);
  c = createFont("Arial", 16, true);
  s = createFont("Arial", 16, true);
  n = createFont("Arial", 16, true);
  menu = true;
  displayables.add(new Block(0, 0, 20, 400, 100));
  displayables.add(new Block(580, 0, 20, 400, 100));
  displayables.add(new Block(20, 0, 560, 20, 100));
  displayables.add(new Block(20, 380, 560, 20, 100));
  displayables.add(new Block(300, 200, 20, 20, 100));
  for (int i = 0; i < displayables.size(); i ++) {
    blocks.add((Block)(displayables.get(i)));
  }
  displayables.add(new LazerDrop(150, 250));
  Warp w = new Warp(80, 50, 20, 150); 
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

public void makeMenu() {
  background(255, 0, 0); 
  textFont(c, 36);
  fill(255);
  text("Join as Server", 0, 150);
  textFont(s, 36);
  fill(255);
  text("Join as Client", 0, 300);
  if (mousePressed) {
    if (mouseX >= 0 && mouseX <= 250 && mouseY<= 150 && mouseY>= 100) {
      background(255, 0, 0); 
      textFont(n, 36);
      fill(255);
      text("Input Player Number 1 -4", 0, 150);

      if (keyPressed) {
        if (key=='1') {
          playerCount =1;
          amServer = true;
        }
        if (key=='2') {
          playerCount =2;
          amServer = true;
        }
        if (key=='3') {
          playerCount =3;
          amServer = true;
        }
        if (key=='4') {
          playerCount =4;
          amServer = true;
        }
      }
    } 
    if (mouseX >= 0 && mouseX <= 250 && mouseY<= 300 && mouseY>= 250) {
      background(255, 0, 0); 
      textFont(n, 36);
      fill(255);
      text("Input Player Number 1 -4", 0, 150);

      if (keyPressed) {
        if (key=='1') {
          playerCount =1;
          amClient = true;
        }
        if (key=='2') {
          playerCount =2;
          amClient = true;
        }
        if (key=='3') {
          playerCount =3;
          amClient = true;
        }
        if (key=='4') {
          playerCount =4;
          amClient = true;
        }
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
          //System.out.println("bull");
          i --;
        }
      } else {
        System.out.println("player");
        if (moveables.get(i) instanceof Player) {
          Player tmp = (Player) moveables.get(i);
          for (int d = 0; d < 360; d ++) {
            System.out.println(tmp.ellip(d)[0]);
            System.out.println(tmp.ellip(d)[1]);

            if (blocks.get(k).amBox(tmp.ellip(d)[0], tmp.ellip(d)[1])) {// this has to be made to check for all tips of triangle 
              tmp.setCol(true); // this nees to do something to hold back or turn triangle
              System.out.println("true");
              d = 361;
              k = blocks.size();
            } else {
              tmp.setCol(false);
            }
          }
        }
      }
    }
  }
}


public void playCollide() {
  for (int i = 0; i < players.size(); i ++) {
    for (int k = 0; k < blocks.size(); k ++) {
      if (players.get(i) instanceof Player) {
        Player tmp = (Player) players.get(i);
        for (int d = 0; d < 360; d ++) {
          //System.out.println(tmp.ellip(d)[0]);
          //System.out.println(tmp.ellip(d)[1]);

          if (blocks.get(k).amBox(tmp.ellip(d)[0], tmp.ellip(d)[1])) {// this has to be made to check for all tips of triangle 
            tmp.setCol(true); // this nees to do something to hold back or turn triangle
            //System.out.println("true");
            d = 361;
            k = blocks.size();
          } else {
            tmp.setCol(false);
          }
        }
      }
    }
    for (int f = 0; f < displayables.size(); f ++) {
      if (displayables.get(f) instanceof LazerDrop) {
        if (((LazerDrop)displayables.get(f)).amLazer(players.get(i).x, players.get(i).y)) {
          players.get(i).hasLazer = true;
          displayables.remove(f);
          f --;
        }
      }
      if (displayables.get(f) instanceof Lazer && lazerTime > 9) {
        displayables.remove(f);
        f --;
        players.get(i).hasLazer = false;
        lazerTime = 0;
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
      server.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," + p.shot+"," );
    } else {
      client.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," + p.shot+"," );
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

  int shot = (int)Float.parseFloat(sh);
  float xVal = Float.parseFloat(x);
  float yVal = Float.parseFloat(y);
  float hea = Float.parseFloat(heading);
  int des =(int) Float.parseFloat(designation);


  players.get(des).x = xVal;
  players.get(des).y = yVal;
  players.get(des).heading = hea;

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
          if (p.hasLazer) {
            if (lazerTime == 0) {
              Lazer temp = new Lazer(p.x, p.y, p.heading);
              displayables.add(temp);
            }

            lazerTime ++;
          } else {
            if (p.time > 15 && p.canShoot() ) {
              Bullet b = new Bullet((float)(p.x + (30 * Math.cos(p.heading))), (float)(p.y + (30 * Math.sin(p.heading))), p.heading);
              displayables.add(b);
              positionables.add(b);
              moveables.add(b);
            }
          }
        }
        collision();
        playCollide();
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
      myPlayer=playerCount-1;
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