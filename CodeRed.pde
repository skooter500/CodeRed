import ddf.minim.*;
import de.ilu.movingletters.*;

float timeDelta = 1.0f / 60.0f; 

boolean[] keys = new boolean[526];
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
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
float turretHUDStart = 0;

void spawn()
{
  if (frameCount % 60 == 0)
  {
    println("New enemy");
    GameObject ego = new GameObject();
    ego.addComponent(new Enemy(ego, red)); 
    ego.position = currentLevel.path.get(0).get();
    ego.position.x -= currentLevel.cellWidth;
    gameObjects.add(ego);
  }
}

void setup()
{
  size(600, 600);
  
  border = 60;    
    
  
  GameObject level = new GameObject();
  currentLevel = new Level(level, "level1.txt");
  
  level.addComponent(currentLevel);
  gameObjects.add(level);
    
  for(int i = 0 ; i < numTurrets ; i ++)
  {
    // Add the HUD turrents
    GameObject tgo = new GameObject();
    
    Turret t = new Turret(tgo, true, turretColors[i]);
    tgo.addComponent(t);
    tgo.position.x = 40 + (i * 80);
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
   for(int i = 0 ; i < numTurrets ; i ++)
   {
     stroke(turretColors[i]);
     float x = 60 + (i * 80);
     printText("x" + turretCount[i], font_size.small, (int)x, (int)y);
   }
}

void draw()
{
  background(0);
  stroke(0, 255, 255);  
  
  for(int i = gameObjects.size() - 1 ; i >= 0 ; i --)
  {
    GameObject go = gameObjects.get(i);
    if (go.alive)
    {
      go.update();
      go.render();
    }
    else
    {
      gameObjects.remove(i);
    }
  }
  
  drawStats();
  spawn();
}

void mousePressed()
{
  // Check
  if (mouseY > 
}

void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}