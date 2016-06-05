import processing.net.*; //<>//

public interface Positionable {
  public boolean state();
  public boolean setState(boolean b);
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

String served = "127.0.0.1";
String eastwood = "127.0.0.1";

int playerCount=0;
int myPlayer=0;
int lazerTime = 0;
int clientCount = 0;

boolean aDown, dDown, menu, amServer, amClient, started, mouseClient, mouseServer, lazerout, stopdam, menu2;

char current;
Server server;
Client client;
int menutime;

public void setup() {
  size(600, 400);
  c = createFont("Arial", 16, true);
  s = createFont("Arial", 16, true);
  n = createFont("Arial", 16, true);
  menu = true;
  started=false;
  mouseServer=false;
  mouseClient=false;
  lazerout = false;
  stopdam = false;
  menu2 =false;
  displayables.add(new Block(0, 0, 20, 400, 100, false));
  displayables.add(new Block(580, 0, 20, 400, 100, false));
  displayables.add(new Block(20, 0, 560, 20, 100, false));
  displayables.add(new Block(20, 380, 560, 20, 100, false));
  displayables.add(new Block(300, 200, 20, 20, 100, false));
  displayables.add(new Block(450, 200, 20, 20, 100, true));

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
  fill(255);
  menutime ++;
  if (!mouseServer&&!mouseClient) {
    textFont(c, 36);
    text("Join as Server", 0, 150);
    textFont(s, 36);
    text("Join as Client", 0, 300);
  }
  if (((mousePressed&&(mouseX >= 0 && mouseX <= 250 && mouseY<= 150 && mouseY>= 100))||mouseServer)&&!menu2) {
    mouseServer=true;
    textFont(n, 20);
    if (! menu2) {
      text("Input Server I.P. address then press enter. Do not move mouse", 0, 150);
      if (keyPressed) {
        if (key != ENTER && served == "127.0.0.1") {
          served = "";
        }
        if (key == BACKSPACE && served.length() > 0) {
          served = served.substring(0, served.length() -1);
        } else if (key==ENTER) {
          menu2 = true;
        } else if (menutime % 10 == 0) {
          served += current;
        }
      }
    }
    PFont br = createFont("Arial", 16, true);
    textFont(br, 20);
    text(served, 200, 300);
  } else if (((mousePressed&&(mouseX >= 0 && mouseX <= 250 && mouseY<= 300 && mouseY>= 250))||mouseClient)&&!menu2) {
    mouseClient=true;
    textFont(n, 20);
    if (! menu2) {
      text("Input Server I.P. address then press enter. Do not move mouse", 0, 150);
      if (keyPressed) {
        if (key != ENTER && served == "127.0.0.1") {
          served = "";
        }
        if (key == BACKSPACE && served.length() > 0) {
          served = served.substring(0, served.length() -1);
        } else {
          current=key;
          if (key == ENTER) {
            menu2 = true;
          } else if (menutime % 10 == 0) {
            served += current;
          }
        }
      }
      PFont br = createFont("Arial", 16, true);
      textFont(br, 20);
      text(served, 200, 300);
    }
  } 
  if (menu2) {
    text("Wait for everyone to input ip. Then input Player Number 1 -4. ", 0, 150);
    if (keyPressed) {
      if (key=='1') {
        playerCount =1;
        if (mouseServer) {
          amServer=true;
        } else {
          amClient = true;
        }
      }
      if (key=='2') {
        playerCount =2;
        if (mouseServer) {
          amServer=true;
        } else {
          amClient = true;
        }
      }
      if (key=='3') {
        playerCount =3;
        if (mouseServer) {
          amServer=true;
        } else {
          amClient = true;
        }
      }
      if (key=='4') {
        playerCount =4;
        if (mouseServer) {
          amServer=true;
        } else {
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
          temp.state=false;
          k = blocks.size();
        }
      } else {
        if (moveables.get(i) instanceof Player) {
          Player tmp = (Player) moveables.get(i);
          for (int d = 0; d < 360; d ++) {
            if (blocks.get(k).amBox(tmp.ellip(d)[0], tmp.ellip(d)[1])) {
              tmp.collide=true; 
              d = 361;
              k = blocks.size();
            } else {
              tmp.collide=false;
            }
          }
        }
      }
    }
  }
}

public void beenShot() { 
  for (int i = 0; i < players.size(); i ++) {
    for (int k = 0; k < displayables.size(); k ++) {
      if (displayables.get(k) instanceof Bullet) {
        if (players.get(i).inTriangle(((Bullet)displayables.get(k)).x, ((Bullet)displayables.get(k)).y)) {
          Bullet temp = (Bullet) displayables.get(k);
          temp.state=false;
          players.get(i).hp --;
        }
      }
      if (displayables.get(k) instanceof Lazer && players.get(i).hasLazer==0 && !stopdam) {
        Lazer temp = (Lazer) displayables.get(k);
        Player tempo = players.get(i);
        float len = (float)Math.sqrt(Math.pow((temp.xx1-temp.xx2), 2.0) + Math.pow((temp.yy1-temp.yy2), 2.0));
        for (float w = 0; w <= len; w++) {
          if (tempo.inTriangle(temp.xx1 + (w * cos(temp.heading)), temp.yy1 + (w * sin(temp.heading)))) {
            tempo.hp --;
            stopdam = true;
            w = len + 1;
          }
        }
      }
    }
  }
}

public void playCollide() {
  for (int i = 0; i < players.size(); i ++) {
    Player tmp = players.get(i);
    for (int k = 0; k < blocks.size(); k ++) {
      for (int d = 0; d < 360; d ++) {
        if (blocks.get(k).amBox(tmp.ellip(d)[0], tmp.ellip(d)[1])) {
          if (! blocks.get(k).boost) {
            tmp.collide=true;
            d = 361;
            k = blocks.size();
          } else {
            tmp.boost= true;
            d = 361;
            k = blocks.size();
          }
        } else {
          tmp.collide=false;
          tmp.boost = false;
        }
      }
    }
    for (int f = 0; f < displayables.size(); f ++) {
      if (displayables.get(f) instanceof LazerDrop) {
        if (((LazerDrop)displayables.get(f)).amLazer(tmp.x, tmp.y) && tmp.hp != 1) {
          tmp.hasLazer = 1;
          displayables.get(f).setState(false);
        }
      }
      if (displayables.get(f) instanceof Lazer && lazerTime > 15) {
        displayables.get(f).setState(false);
        tmp.hasLazer = 0;
        lazerout = false;
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
public void send(Player p) {
  try {
    if (amServer) { 
      server.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," + p.shot+"," + p.hasLazer + "," + p.hptime +"," + p.hp +",!" );
    } else {
      client.write(p.designation+"," + p.x+ "," + p.y + "," + p.heading+"," +  p.shot+"," + p.hasLazer + "," + p.hptime +"," + p.hp +",!" );
    }
    p.shot = 0;
  }
  catch(Exception e) {
    send(p);
  }
}

public String read(String s, int index) {
  try {
    if (amServer) {
      Client player=server.clients[index];
      if (player !=null) {
        s += player.readString();
      }
      if (!nullCheck(s)) {
        int loc=0;
        while (loc<server.clientCount&&player!=null) {
          player=server.clients[loc];
          if (loc!=index) {
            player.write(s);
          }
          loc+=1;
        }
      }
    } 
    if (!nullCheck(s)) {
      s=parse(s);
    }
    return s;
  }
  catch(Exception e) {
    return "";
  }
}
private boolean nullCheck(String s) {
  if (s.indexOf(",")==-1) {
    return true;
  }
  return false;
}
private boolean fullCheck(String s) {
  if (s.indexOf("!")==-1) {
    return true;
  }
  return false;
}
public String parse(String s) {
  if (nullCheck(s)) {
    return "";
  }
  String designation = s.substring(0, s.indexOf(","));
  int des =Integer.parseInt(designation);
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)||des==myPlayer) {
    return "";
  }
  String x = s.substring(0, s.indexOf(","));
  float xVal = Float.parseFloat(x);
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)) {
    return "";
  }
  String y = s.substring(0, s.indexOf(","));
  float yVal = Float.parseFloat(y);
  s = s.substring(s.indexOf(",") + 1);
  if (nullCheck(s)) {
    return "";
  }
  String heading = s.substring(0, s.indexOf(","));
  float hea = Float.parseFloat(heading);
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return "";
  }
  String sh = s.substring(0, s.indexOf(","));
  int shot = (int)Float.parseFloat(sh);
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return "";
  }
  String la = s.substring(0, s.indexOf(","));
  int laa = (int)Float.parseFloat(la);
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return "";
  }
  String hh = s.substring(0, s.indexOf(","));
  int h = (int)Float.parseFloat(hh);
  s = s.substring(s.indexOf(",")+1);
  if (nullCheck(s)) {
    return "";
  }
  String hhhh = s.substring(0, s.indexOf(","));
  int hhh = (int)Float.parseFloat(hhhh);
  s = s.substring(s.indexOf(",")+1);

  players.get(des).setState(true);
  players.get(des).x = xVal;
  players.get(des).y = yVal;
  players.get(des).heading = hea;
  players.get(des).hasLazer = laa;
  players.get(des).hptime = h;
  players.get(des).hp= hhh;


  if (shot==1&&laa==0) {
    Bullet b = new Bullet((float)(xVal + (30 * Math.cos(hea))), (float)(yVal + (30 * Math.sin(hea))), hea);
    displayables.add(b);
    positionables.add(b);
    moveables.add(b);
  } else if (laa==1&&shot==1&&lazerTime==0) {
    Lazer temp = new Lazer(xVal, yVal, hea);
    lazerout = true;
    displayables.add(temp);
  }
  return s;
}

public void playerMovement() {
  try {
    Player p=players.get(myPlayer);
    p.move();
    if (dDown) {
      p.heading+=.05;
    }
    if (aDown) {
      if (p.hasLazer==1) {
        if (lazerTime == 0) {
          Lazer temp = new Lazer(p.x, p.y, p.heading);
          lazerout = true;
          displayables.add(temp);
          p.shot=1;
        }
      } else {
        if (p.time > 15 && p.canShoot() ) {
          Bullet b = new Bullet((float)(p.x + (30 * Math.cos(p.heading))), (float)(p.y + (30 * Math.sin(p.heading))), p.heading);
          displayables.add(b);
          positionables.add(b);
          moveables.add(b);
        }
      }
    }

    Client player=null;
    String s="";
    int index=0;
    if (amServer&&server.clients.length>1) {
      player=server.clients[0];
    } else {
      s=client.readString();
      client.clear();
    }
    while (amServer&&player!=null&&index<server.clientCount) {
      read(s, index);
      index+=1;
      if (index<server.clientCount) {
        player=server.clients[index];
      }
    }
    while (amClient&&!fullCheck(s)&&index<playerCount) {
      read(s.substring(0, s.indexOf("!")+1), 0);
      s=s.substring(s.indexOf("!")+1);
      index+=1;
    }
  }
  catch(Exception e) {
  }
}
void serverEvent(Server someServer, Client someClient) {
  clientCount+=1;
  server.write("Client:"+clientCount);
}
void clientEvent(Client someClient) {
  if (myPlayer!=0&&!started) {
    if (client.readString().indexOf(":")!=-1) {
      clientCount+=1;
      client.clear();
    }
  }
}
public void draw() {
  background(0);
  if (menu||clientCount<playerCount-1) { 
    makeMenu();
    if (amServer&&server==null) {
      myPlayer = 0;
      server=new Server(this, 6666, served); 
      menu=false;
    }
    if (amClient&&client==null) {
      try {
        client=new Client(this, served, 6666);
        String s=client.readString();
        myPlayer=Integer.parseInt(s.substring(s.indexOf(":")+1));
        clientCount=myPlayer;
        menu=false;
        client.clear();
      }
      catch(Exception e) {
      }
    }
  } else {
    if (clientCount>=playerCount-1&&!started) {
      for (int i = 0; i < playerCount; i++) {
        Player p = new Player(i);
        displayables.add(p);
        positionables.add(p);
        players.add(p);
      }
      started=true;
    }
    if (lazerout) {
      lazerTime ++;
    }
    playerMovement();
    beenShot();
    collision();
    playCollide();
    warped();
    send(players.get(myPlayer));
    for ( Moveable m : moveables) {
      if (m.state()) {
        m.move();
        m.collide(positionables);
      }
    }

    for ( Displayable d : displayables) {
      if (d.state()) {
        d.display();
      }
    }

    for (int i = moveables.size() - 1; i >= 0; i--) {
      if (!moveables.get(i).state()) {
        moveables.remove(i);
      }
    }

    for (int i = displayables.size() - 1; i >= 0; i--) {
      if (!displayables.get(i).state()&&!(displayables.get(i) instanceof Player)) {
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