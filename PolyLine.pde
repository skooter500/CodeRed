class PolyLine extends GameComponent
{
  color c;
  
  PolyLine(GameObject gameObject, color c)
  {
    super(gameObject);
  }
  
  void render()
  {
    stroke(c);
    noFill();
    pushMatrix();
    translate(gameObject.position.x, gameObject.position.y);
    rotate(gameObject.rot);    
    for (int i = 1 ; i < vertices.size() ; i += 2)
    {
        PVector from = vertices.get(i - 1);
        PVector to = vertices.get(i);            
        line(from.x, from.y, to.x, to.y);
    }
    popMatrix();
  }  
}