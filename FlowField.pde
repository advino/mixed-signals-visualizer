class FlowField {
 PVector [][] field;
 int cols, rows;
 int resolution;
 
 FlowField(int r) {
  
   resolution = r;
   cols = width/resolution;
   rows = height/resolution;
   field = new PVector[cols][rows];
   init();
 }
  
 void init() {
  float xoff = 0;
  for(int i = 0; i < cols; i++) {
   for(int j = 0; j < rows; j++) {
    field[i][j] = PVector.random2D();
   }
  }
 }
 
 PVector lookup(PVector lookup) {
  int column = int(constrain(lookup.x/resolution, 0, cols-1));
  int row = int(constrain(lookup.y/resolution, 0, rows-1));
  
  return field[column][row].get();
 }
  
}
