class Turret extends GameComponent
{  
  PolyLine polyLine;
  boolean hud;
  
  GameObject enemy;
  float range = 100.0f;
  int fireRate = 5;
  
  Turret(GameObject gameObject, boolean hud, color c)
  {
    super(gameObject);     //<>//
    this.hud = hud;
    polyLine = new PolyLine(gameObject, c);
    gameObject.addComponent(polyLine);
  }
  
  GameObject searchForEnemy()
  {
    GameObject enemy = null;
    float minDist = Float.MAX_VALUE;
    for(GameObject e:enemies)
    {
      float dist = PVector.dist(e.position, gameObject.position);
      if (dist < range && dist < minDist)
      {
        enemy = e;
        minDist = dist;
      }
    }
    return enemy;
  }
  
  void render()
  {
  }
  
  void update()
  {
    if (!hud)
    {
      if (enemy == null)
      {
        enemy = searchForEnemy();
      }
      else
      {
        PVector toEnemy = PVector.sub(gameObject.position, enemy.position);
        float dist = PVector.dist(enemy.position, gameObject.position);
        gameObject.rot = atan2(toEnemy.y, toEnemy.x) - HALF_PI;
        
        if (dist < range)
        {
          enemy = null;
        }                
      }
    }
  }
  
  void initialize()
  {
    float radius = turretWidth * 0.3f;    //<>//
    int sides = 8;
    float thetaInc = TWO_PI / (float) sides;
    float lastX = 0, lastY = - radius;
    float x, y;
    
    polyLine.vertices.add(new PVector(0, - turretWidth  * 0.4f));  
    polyLine.vertices.add(new PVector(0, - radius));
    
    for (int i = 1 ; i < sides ; i ++)
    {
      float theta1 = (float) i  * thetaInc;
      x = sin(theta1) * radius;
      y = -cos(theta1) * radius;

      polyLine.vertices.add(new PVector(lastX, lastY));  
      polyLine.vertices.add(new PVector(x, y));  
      lastX = x;
      lastY = y; 
    } 
    polyLine.vertices.add(new PVector(lastX, lastY));  
    polyLine.vertices.add(new PVector(0, -radius));   
  }
}