class Enemy extends GameComponent
{
  PolyLine polyLine;
  int currentWaypoint = 0;
  PVector velocity;
  int health;
  color c;
  
  Enemy(GameObject gameObject, color c)
  {
    super(gameObject);
    polyLine = new PolyLine(gameObject, c);
    gameObject.addComponent(polyLine);
    velocity = new PVector();
    health = 10;
    this.c = c;
    initialize();
  }
  
  void update()
  {    
    // AM I dead!
    if (health <= 0)
    {
       enemies.remove(gameObject);
       gameObjects.remove(gameObject);      
       score ++;
       
       GameObject ex = new GameObject();
       Explosion explosion = new Explosion(
            gameObject
            , ((PolyLine)gameObject.components.get(0)).vertices
            , gameObject.position
            , c
            );
       ex.addComponent(explosion);    
       gameObjects.add(ex);
       playSound(explosionSound);
       return;
    }
    
    PVector toWaypoint = PVector.sub(
      currentLevel.path.get(currentWaypoint)
      , gameObject.position
      );
   
   toWaypoint.normalize();
   gameObject.position.add(toWaypoint);
   gameObject.rot = toWaypoint.heading() + HALF_PI;
    
    if (toWaypoint.mag() < 1.0f)
    {
      currentWaypoint ++;
      if (currentWaypoint == currentLevel.path.size())
      {
        println("Removing enemy");
        score --;
        gameObjects.remove(this.gameObject);
        enemies.remove(this.gameObject);
      }
      
    }     
  }
  
  void initialize()
  {
    float radius = turretWidth * 0.2f;    
    int sides = 4;
    float thetaInc = TWO_PI / (float) sides;
    float lastX = 0, lastY = - radius;
    float x, y;
    
    polyLine.vertices.add(new PVector(0, - turretWidth * 0.4f));  
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
  
  void render()
  {
    
  }
  
}