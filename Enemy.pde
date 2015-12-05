class Enemy extends GameComponent
{
  PolyLine polyLine;
  int currentWaypoint = 0;
  PVector velocity;
  
  Enemy(GameObject gameObject, color c)
  {
    super(gameObject);
    polyLine = new PolyLine(gameObject, c);
    gameObject.addComponent(polyLine);
    velocity = new PVector();
    initialize();
  }
  
  void update()
  {
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
        this.gameObject.alive = false;
      }
    }     
  }
  
  void initialize()
  {
    println("Initialising the enemy");
    float radius = currentLevel.cellWidth * 0.2f;    
    int sides = 4;
    float thetaInc = TWO_PI / (float) sides;
    float lastX = 0, lastY = - radius;
    float x, y;
    
    polyLine.vertices.add(new PVector(0, - currentLevel.cellWidth * 0.4f));  
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