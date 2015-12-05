class KeyMovement extends GameComponent
{
  char forward;
  char left;
  char right;
  
  KeyMovement(GameObject gameObject, char forward, char left, char right)
  {
    super(gameObject);
    this.left = left;
    this.right = right;
    this.forward = forward;
  }
 
 void update()
 {
   gameObject.forward.x = sin(gameObject.rot);
   gameObject.forward.y = - cos(gameObject.rot);
   
   if (keys[forward])
   {
     gameObject.position.add(gameObject.forward);
   }
      
   if (keys[left])
   {
     gameObject.rot -= timeDelta;
   }
   
   if (keys[right])
   {
     gameObject.rot += timeDelta;
   }
 } 
}