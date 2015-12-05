class Level extends GameComponent
{
  float cellWidth;
  float cellHeight;
  int rows, cols;
  String fileName;
  int[][] board;
  float border;
  
  Level(GameObject gameObject, String fileName)
  {
    super(gameObject);
    this.fileName = fileName;
  }
  
  void initialize()
  {
    String[] lines = loadStrings(fileName);
    
    rows = lines.length;
    cols = lines[0].length();
    
    board = new int[rows][cols];
    
    border = height * 0.1f;    
    cellWidth = width / cols;
    cellHeight = (height - (border * 2.0f)) / rows;    
        
    for(int i = 0 ; i < lines.length ; i ++)
    {
      for (int j = 0 ; j < lines[i].length() ; j ++)
      {
        board[i][j] = lines[i].charAt(j) - '0';
      }
    }
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
  
  void render()
  {   
    
    stroke(red);
    line(0, border, width, border);
    line(0, height - border, width, height - border); //<>//
    for(int row = 0 ; row < rows ; row ++) //<>//
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
  }   
}