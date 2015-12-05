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

void setup()
{
  size(600, 600);
  
  GameObject level = new GameObject();
  
  level.addComponent(new Level(level, "level1.txt"));
  gameObjects.add(level);
 
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
  printText("Score: " + score, font_size.small, 10, 10);
}


void draw()
{
  background(0);
  stroke(0, 255, 255);  
  for(GameObject gameObject:gameObjects)
  {
    gameObject.update();
    gameObject.render();
  }
  
  drawStats();
}

void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}