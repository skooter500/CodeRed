import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;
import de.ilu.movingletters.*;

float timeDelta = 1.0f / 60.0f; 

boolean[] keys = new boolean[526];
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<GameObject> enemies = new ArrayList<GameObject>();
MovingLetters[] letters = new MovingLetters[3];

color red = color(210, 10, 11);
color green = color(0, 250, 0);
color blue = color(10, 5, 190);
color lightBlue = color(50, 230, 230);
color purple = color(215, 30, 220);

int CENTRED = -1;
int score = 0;
Level currentLevel;
float border;
int numTurrets = 3;
int[] turretCount = new int[numTurrets];
color[] turretColors = {purple, blue, red};

float turretWidth = 0;
float turretHUDx = 0;
float turretHUDy = 0;

GameObject mouseTurret = null;

AudioPlayer explosionSound;
AudioPlayer shootSound;
AudioPlayer backgroundSound;

int gameState = 0;
Minim minim;//audio context

void splash()
{
  background(0);
  stroke(255, 0, 0); 
  printText("Code Red", font_size.large, CENTRED, 100);  
  stroke(255);
  printText("Programmed by Bryan Duggan", font_size.large, CENTRED, 300);
  printText("Soundtrack by Darren Fitzpatrick", font_size.large, CENTRED, 400);
  if (frameCount / 60 % 2 == 0)
  {
    printText("Press SPACE to play", font_size.large, CENTRED, height - 100);  
  }
  if (checkKey(' '))
  {
    gameState = 1;
    playSound(backgroundSound, true);
  }
}

void spawn()
{
  if (frameCount % 60 == 0)
  {
    GameObject ego = new GameObject();
    ego.addComponent(new Enemy(ego, red)); 
    ego.position = currentLevel.path.get(0).get();
    ego.position.x -= currentLevel.cellWidth;
    gameObjects.add(ego);
    enemies.add(ego);
  }
}

void playSound(AudioPlayer sound)
{
  playSound(sound, false);
}

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];  
  }
  return false;
}

void playSound(AudioPlayer sound, boolean loop)
{
  if (sound == null)
  {
    return;
  }
  sound.setGain(14);
  if (!loop)
  {
    sound.rewind();
  }
  else
  {
    sound.loop();
    if (sound.isPlaying())
    {
      return;
    }
  }    
  
  sound.play(); 
}

void setup()
{
  fullScreen();
  
  minim = new Minim(this);  
  
  explosionSound = minim.loadFile("exp.wav");
  shootSound = minim.loadFile("shoot.wav");
  backgroundSound = minim.loadFile("drumbedtrack1.mp3");
  
  //size(600, 600);
  
  border = 60;    
  turretWidth = 60;
  turretHUDx = 20;
  turretHUDy = 0;
  
  turretCount[0] = 10;
  turretCount[1] = 10;
  turretCount[2] = 10;
      
  GameObject level = new GameObject();
  currentLevel = new Level(level, "level1.txt");
  
  level.addComponent(currentLevel);
  gameObjects.add(level);
    
  float startX = turretHUDx + (turretWidth * 0.5f);
  float gap = turretWidth * 1.5f;
  for(int i = 0 ; i < numTurrets ; i ++)
  {
    // Add the HUD turrents
    GameObject tgo = new GameObject();
    
    Turret t = new Turret(tgo, true, turretColors[i]);
    tgo.addComponent(t);
    tgo.position.x = startX + (gap * i);
    tgo.position.y = height - (border / 2);    
    gameObjects.add(tgo);
  }
  
  
  /*ship = new GameObject();
  ship.addComponent(new ShipDrawer(ship, 20.0f, 20.0f));
  ship.addComponent(new KeyMovement(ship, 'W', 'A', 'D'));
  
  ship.position.x = 100;
  ship.position.y = 100;
  
  gameObjects.add(ship);
  
  GameObject aiShip = new GameObject();
  
  aiShip.addComponent(new ShipDrawer(aiShip, 20.0f, 20.0f));
  aiShip.addComponent(new AIMovement(aiShip, 100));
  
  aiShip.position.x = 200;
  aiShip.position.y = 100;
  
  gameObjects.add(aiShip);
  */  
  
  for (font_size size:font_size.values())
  {
    letters[size.index] = new MovingLetters(this, size.size, 1, 0);
  }
  
  initialize();
}

void printText(String text, font_size size, int x, int y)
{
  if (x == CENTRED)
  {
    x = (width / 2) - (int) (size.size * (float) text.length() / 2.5f);
  }
  letters[size.index].text(text, x, y);  
}

void initialize()
{
  for(GameObject gameObject:gameObjects)
  {
    gameObject.initialize();
  }
}

void drawStats()
{
  stroke(green);
  printText("Score: " + score, font_size.small, 10, 20);
  
  // Draw the turret stats
  float y = height - 40; 
  float startX = turretHUDx + (turretWidth);
  float gap = turretWidth * 1.5f;
   for(int i = 0 ; i < numTurrets ; i ++)
   {
     stroke(turretColors[i]);
     float x = startX + (i * gap);
     printText("" + turretCount[i], font_size.small, (int)x, (int)y);
   }
}

void game()
{
  for(int i = gameObjects.size() - 1 ; i >= 0 ; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
  
  drawStats();
  spawn();
}

void draw()
{
  background(0);
  stroke(0, 255, 255);  
  
  switch(gameState)
  {
    case 0:
      splash();
      break;
    case 1:
      game();
  }   
}

void mouseClicked()
{
  // Check are we dropping a turret
  if (mouseTurret != null)
  {
    ((Turret)mouseTurret.components.get(1)).hud = false;
    mouseTurret.components.remove(2);
    mouseTurret = null;
  }
  
  float startX = turretHUDx;
  float gap = turretWidth * 1.5f;
  
  // Check
  if (mouseY > height - border)
  {
    int turretIndex = (int)((mouseX - startX) / gap);  
    if (turretIndex >= 0 && turretIndex < numTurrets)
    {
      println(turretIndex);
      if (turretCount[turretIndex] > 0)
      {
        turretCount[turretIndex] --;
        mouseTurret = new GameObject();
        Turret t = new Turret(mouseTurret, true, turretColors[turretIndex]);
        t.initialize();
        mouseTurret.addComponent(t);
        mouseTurret.addComponent(new MouseFollow(mouseTurret));        
        gameObjects.add(mouseTurret);        
      }      
    }    
  }
}

void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}