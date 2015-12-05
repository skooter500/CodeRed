class GameObject
{
    PVector position;
    PVector look;
    float rot;
    boolean alive;

    ArrayList<GameComponent> components;
    
    GameObject()
    {
      components = new ArrayList<GameComponent>();
      position = new PVector();
      look = new PVector(0, -1);
      alive = true;
    }
    
    void initialize()
    {
      for(GameComponent component:components)
      {
        component.initialize();
      }
    }

    void update()
    {
      for(GameComponent component:components)
      {
        component.update();
      }
    }
    
    void render()
    {
      for(GameComponent component:components)
      {
        component.render();
      }
    }

    void addComponent(GameComponent component)
    {
      components.add(component);
    }
        
}