class Explosion extends GameComponent
{
  ArrayList<PVector> directions = new ArrayList<PVector>();
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  color colour;
  float speed = 1.5f;

  float timeDelta = 1.0 / 60.0f;
  float ellapsed = 0;
  float liveFor = 2.0f;
  
  Explosion(GameObject go, ArrayList<PVector> vertices, PVector pos, color colour)
  {
    super(go);
    this.gameObject.position = pos;
    this.colour = colour;
    for(PVector vertex:vertices)
    {
      this.vertices.add(vertex.get());
    }
    for (int i = 0 ;  i < vertices.size() ; i +=2)
    {
        PVector dir = new PVector(random(-1, 1), random(-1, 0));
        dir.normalize();
        dir.mult(speed);
        directions.add(dir);
    }
    //playSound(explosionSound);
  }

  void update()
  {    
    for (int i = 0 ; i < vertices.size() ; i ++)
    {
      PVector velocity = directions.get(i / 2);
      vertices.get(i).add(velocity);
    }
    ellapsed += timeDelta;
    if (ellapsed > liveFor)
    {
      gameObjects.remove(this.gameObject);
    }
  }

  void render()
  {
   stroke(255);
   pushMatrix(); 
   translate(gameObject.position.x, gameObject.position.y);
   rotate(gameObject.rot);
   float alpha = (1.0f - ellapsed / liveFor) * 255.0f;
   stroke(red(colour), green(colour), blue(colour), (int)alpha);
   for (int i = 1 ; i < vertices.size() ; i += 2)
    {        
        PVector from = vertices.get(i - 1);
        PVector to = vertices.get(i);            
        line(from.x, from.y, to.x, to.y);
    }   
    popMatrix();  
  }
  
}