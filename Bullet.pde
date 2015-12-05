class Bullet extends GameComponent
{
  color c;
  PVector startPos;
  float range;
  
  Bullet(GameObject go, float x, float y, float range, color c)
  {
    super(go);
    go.position.x = x;
    go.position.y = y;
    startPos = new PVector(x, y);
    this.range = range;
    this.c = c;
  }
  
  void update()
  {
    gameObject.position.add(PVector.mult(gameObject.forward, 5.0f));
    
    float dist = PVector.dist(gameObject.position, startPos);
    if (dist > range)
    {
      gameObjects.remove(gameObject);     
    }
    
    // Check for collisions with the enemies
    for(int i = 0 ; i < enemies.size() ; i ++)
    {      
      GameObject enemy = enemies.get(i);
      float eDist = PVector.dist(enemy.position, gameObject.position);
      if (eDist < 20)
      {
        ((Enemy)enemy.components.get(1)).health --;
        gameObjects.remove(gameObject);
      }
    }
  }
  
  void render()
  {
    pushMatrix();
    translate(gameObject.position.x, gameObject.position.y);
    rotate(gameObject.rot);
    stroke(c);
    line(0, -5, 0, 5);
    popMatrix();
  }
  
}