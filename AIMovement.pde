class AIMovement extends GameComponent
{
  float border;
  
  AIMovement(GameObject gameObject, float border)
  {
    super(gameObject);
    this.border = border;
  }
  
  void update()
  {    
    gameObject.forward.x = sin(gameObject.rot);
    gameObject.forward.y = - cos(gameObject.rot);
    
    gameObject.position.add(gameObject.forward);
    
    if (gameObject.position.x > width - border)
    {
      gameObject.position.x = width - border;
      gameObject.rot -= HALF_PI;
    }
    
    if (gameObject.position.y < border)
    {
      gameObject.position.y = border;
      gameObject.rot -= HALF_PI;
    }
    
    if (gameObject.position.x < border)
    {
      gameObject.position.x = border;
      gameObject.rot -= HALF_PI;
    }
    
    if (gameObject.position.y > height - border)
    {
      gameObject.position.y = height - border;
      gameObject.rot -= HALF_PI;
    }
    
  }
}