class Visualizer {
  ArrayList<Movie> movies;
  Movie active;
  
  int x;
  int y;
  
  int count;
  
  Visualizer(ArrayList<Movie> _movies) {
    movies = _movies;
    count = 0;
    
    x = 0;
    y = 0;
    
    active = movies.get(0);
    active.loop();
  }

  void update() {
    if (count < 12) {
      count ++;
    } else {
      count = 0;
    }

    active.pause();
    active = movies.get(count);
    active.loop();
  }

  void display() {
    pushMatrix();
    translate(x,y);
    //scale(.5);
    imageMode(CORNER);
    image(active,0,0, width, height);
    popMatrix();
  }
}
