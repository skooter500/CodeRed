class Level extends GameComponent
{
  float cellWidth;
  float cellHeight;
  int rows, cols;
  int baseRow, baseCol;
  int startRow, startCol;
  String fileName;
  int[][] board;
  
  ArrayList<PVector> path = new ArrayList<PVector>(); 
  
  Level(GameObject gameObject, String fileName)
  {
    super(gameObject);
    this.fileName = fileName;
  }
  
  void calculatePath()
  {
    
    // Search the edges for the start cell
    startRow = 0;
    startCol = 0;
    for(int row = 0 ; row < rows ; row ++)
    {
      if (getCell(row, 0) == 1)
      {
        startRow = row;
        startCol = 0;
        break;
      }
      if (getCell(row, cols - 1) == 1)
      {
        startRow = row;
        startCol = cols - 1;
        break;
      }
    }
    
    // Find the base
    for(int row = 0 ; row < rows ; row ++) //<>// //<>//
    {
      for(int col = 0 ; col < cols ; col ++)
      {
        if (getCell(row, col) == 2)
        {
          baseRow = row;
          baseCol = col;
        }
      }
    }
    
    println(baseRow, baseCol);
    println(startRow, startCol);
    
    // Now find the path to the end cell
    int row = startRow, col = startCol;
    int prevRow = row, prevCol = col;
    boolean found = false;
    path.clear();
    while (! found)
    {
      path.add(cellToScreen(row, col));
      if ((row == baseRow && col == baseCol) || path.size() == 14)
      {
        println("Found!: " + baseRow + " " + baseCol);
        found = true;
        continue;
      }
      int nextRow = 0, nextCol = 0;
      // Check which dir is free
      // Up
      if (prevRow != row -1 && getCell(row - 1, col) != 0)
      {
        nextRow = row - 1;
        nextCol = col;
        println("up");
      }
      
      // down
      if (prevRow != row + 1 && getCell(row + 1, col) != 0)
      {
        nextRow = row + 1;
        nextCol = col; 
        println("down" + nextRow + " " + nextCol);
      }
      
      // Left
      if (prevCol != col - 1 && getCell(row, col - 1) != 0)
      {
        nextRow = row;
        nextCol = col - 1;
        println("left");
      }
      
      // Right //<>// //<>//
      if (prevCol != col + 1 && getCell(row, col + 1) != 0)
      {
        nextRow = row;
        nextCol = col + 1;
        println("right");
      }
      prevRow = row;
      prevCol = col;
      row = nextRow;
      col = nextCol; 
    }         
  }
  
  PVector cellToScreen(int row, int col)
  {
    float x = (cellWidth * 0.5f) + (col * cellWidth);
    float y = border + (cellHeight * 0.5f) + (row * cellHeight);
    return new PVector(x, y);
  }
  
  void initialize()
  {
    String[] lines = loadStrings(fileName);
    
    rows = lines.length;
    cols = lines[0].length();
    
    board = new int[rows][cols];
    
    cellWidth = width / cols;
    cellHeight = (height - (border * 2.0f)) / rows;    
        
    for(int i = 0 ; i < lines.length ; i ++)
    {
      for (int j = 0 ; j < lines[i].length() ; j ++)
      {
        board[i][j] = lines[i].charAt(j) - '0';
      }
    }
    calculatePath();
  }
  
  int getCell(int row, int col)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      return board[row][col];
    }
    else
    {
      return -1;
    }
  }
  
  void drawCell(int row, int col, color c)
  {
    stroke(c);
    float x, y;
    x = col * cellWidth;
    y = border + (row * cellHeight);

    // Top
    if (getCell(row - 1, col) == 0)
    {
      line(x, y, x + cellWidth, y);    
    }
    
    // Bottom
    if (getCell(row + 1, col) == 0)
    {
      line(x, y + cellHeight, x + cellWidth, y + cellHeight);    
    }
    
    // Left
    if (getCell(row, col - 1) == 0)
    {
      line(x, y, x, y + cellHeight);    
    }
    
    // Right
    if (getCell(row, col + 1) == 0)
    {
      line(x + cellWidth, y, x + cellWidth, y + cellHeight);    
    }
    
  }
  
  void drawPath()
  {
    for(PVector waypoint:path)
    {
      ellipse(waypoint.x, waypoint.y, 5, 5);
    }
  }
  
  void render()
  {       
    stroke(red);
    line(0, border, width, border);
    line(0, height - border, width, height - border);
    for(int row = 0 ; row < rows ; row ++) //<>// //<>//
    {
      for(int col = 0 ; col < cols ; col ++)
      {
               
        switch(board[row][col])
        {
          case 1:
            drawCell(row, col, green);
            break;
          case 2:
            drawCell(row, col, lightBlue);
        }                
      }
    }
    drawPath();
  }   
}