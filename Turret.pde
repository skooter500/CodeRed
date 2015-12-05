class Turret extends GameComponent
{  
  PolyLine polyLine;
  boolean hud;
  
  GameObject enemy;
  float range = 100.0f;
  int fireRate = 5;
  color c;
  float ellapsed = 0;
  float toPass = 0;
  
  Turret(GameObject gameObject, boolean hud, color c)
  {
    super(gameObject);     //<>//
    this.hud = hud;
    polyLine = new PolyLine(gameObject, c);
    gameObject.addComponent(polyLine);
    this.c = c;
    toPass = 1.0f / fireRate;
    ellapsed = toPass;
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
        gameObject.forward.x = sin(gameObject.rot);
        gameObject.forward.y = -cos(gameObject.rot);
        
        if (ellapsed > toPass)
        {
          GameObject bullet = new GameObject();
          bullet.addComponent(new Bullet(bullet, gameObject.position.x, gameObject.position.y, range, c));
          bullet.position.add(PVector.mult(gameObject.forward, 15.0f));
          bullet.forward = gameObject.forward.get();
          bullet.rot = gameObject.rot;
          gameObjects.add(bullet);
          ellapsed = 0;
        }
        
        if (dist < range)
        {
          enemy = null;
        }                
      }
    }
    ellapsed += timeDelta;
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