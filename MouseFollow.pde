class MouseFollow extends GameComponent
{
  MouseFollow(GameObject go)
  {
    super(go);
  }
  
  void update()
  {
    gameObject.position.x = mouseX;
    gameObject.position.y = mouseY;    
  }
}