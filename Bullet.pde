class Bullet extends GameComponent
{
  color c;
  
  Bullet(GameObject go)
  {
    super(go);
  }
  
  void render()
  {
    pushMatrix();
    translate(gameObject.position.x, gameObject.position.y);
    rotate(gameObject.rot);
    line(0, -5, 0, 5);
    popMatrix();
  }
  
}