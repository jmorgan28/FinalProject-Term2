# FinalProject-Term2

Team Name: Comsic Partiers<br>
Project Name: Astro Party Clone Wars <br>
Description:<br>

How to Run:<br>


<br>Development Log<br>

5/14/16 <br>

Jackson and Matthew:<br>

-Made Game and Ship Class<br>
-Functions Now include booting game, creation of ship, and ability to move ship.<br>


5/14 - 5/18 <br>

Jackson and Matthew:<br>
- experimented with online server stuff<br>
- studied for AP exams<br>

5/19/16 <br>

Jackson: <br>

- made ship shooting capacity limited <br>
- udjusted bullet orientation to leave tip and continue in right direction <br>
- made class block<br>



5/21/16 <br>

Matthew:<br>
-set up server to client and vice versa messaging<br>
-must specify total number of players before start<br>
<br>
Jackson: <br>

- made blocks and bullets detect when they collide. Made this destroy bullets<br>
- made class warp which distorts bullet movement (currently just changes heading 180 degrees) <br>
- made border<br>
- made parse function to read and use info from the server<br>
- balanced stuff and changed sizes of things<br>

5/22/16 <br>

Jackson: <br>

- made copy of program to test<br>
- got basic multiplayer (one person moves an it appears on screen of the other) working <br>


5/23/16 <br>

Jackson: <br>
- got multiplayer working for up to 2 players<br>
- got bullets working one way only<br>
<br>
Matthew:<br>
- bullets work both ways<br>
- works with theoretically as many as you want(only tried up to 4)<br>
- merged project and project-copy so only difference is boolean specifying if client or server<br>



5/24/16 <br>

Jackson: <br>
- made menu where you can select to be a player or client<br>
- if server is picked must pick player amount (not finished no have to hold mouse and then press number for it to work. Does not send player count accurately to client)<br>

Matthew:<br>
- Set up all of the error handling (tries, catches and the like) to help it not crash when there are concurrency issues

5/25/16 <br>

Jackson: <br>
- made game detect if you collided with the wall. resets position if you did.<br>
Matthew:<br>
- did some menu stuff
5/26/16 <br>

Jackson: <br>
- made laser pickup class<br>
- made ability to shoot laser and laser class pickup<br>
- made it so when collide with wall can still move (not reset to place) so that you can turn and get away from wall<br>

5/27/16 <br>
Matthew:<br>
- made menu more functional for more players
- set up a designation system for sending messages

5/29/16 <br>

Jackson: <br>
- made bullets do damage<br>
- made bullet detection<br>
- made it so players could die<br>


5/30/16 <br>

Jackson: <br>
- made pilot mode for when health is 1<br>
- adjusted display for this mode<br>
- adjusted movement for this mode<br>

5/31/16 <br>
Matthew:<br>
- worked on lowering lag between clients
6/1/16 <br>

Jackson: <br>
- now don't bounce back when collide with wall. Glide against it<br>
- balance changes<br>
- made time for pilot mode so eventually return to ship mode if not shot<br>
- made collission detection for lazer (not sure if works. for some reason lazer is acting infinitely in multiplayer)<br>
- broke collision in corners<br>
- broke collission for stray blocks(now act as speed boost)<br>

6/2/16 <br>

Jackson: <br>
- now collision with wall works correctly and diferently depending on location<br>
- can no longer escape map<br>
- made speed boost<br>
- made lazer work correctly on server side<br>


6/3/16 - 6/5/16 <br>
Jackson: <br>
- Made collision with laser work<br>
- Stopped infinite laser glitch <br>
- Made different spawn points and colors for each player<br>
- Got rid of glitch where error would occur when shooting someone<br>
- Made new menu screen where you can input a server so you don't have to just play locally<br>
- 
6/3/16<br>
Matthew:<br>
- worked on lowering lag between clients and clients now have equivalent lag
6/4/16<br>
Matthew:<br>
-everyone can hear
-they all know what everyone is doing and at the right speed
6/5/16<br>
Matthew:<br>
-fixed health restore across clients
-fixed using the lazer power up across clients
-clients no longer randomly disappear from people's screens
