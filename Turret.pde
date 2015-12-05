class Turret extends GameComponent
{  
  PolyLine polyLine;
  boolean hud;
  
  Turret(GameObject gameObject, boolean hud, color c)
  {
    super(gameObject);     //<>//
    this.hud = hud;
    polyLine = new PolyLine(gameObject, c);
    gameObject.addComponent(polyLine);
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