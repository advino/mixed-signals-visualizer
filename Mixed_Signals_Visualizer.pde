import processing.video.*;
import http.requests.*;

ArrayList<Movie> movies;
ArrayList<PFont> fonts;

int mode;

Scroller scroll;
Visualizer visual;
Capture myCap;
Slit scanner;


void setup() {
  fullScreen(P2D);
  //size(960, 540, P2D);
  movies = new ArrayList<Movie>();
  fonts = new ArrayList<PFont>();

  myCap = new Capture(this, Capture.list()[0]);
  scanner = new Slit(myCap);

  frameRate(60);
  smooth(10);

  for (int i = 0; i < 29; i ++) {
    movies.add(new Movie(this, i + ".mov"));
  }
  for (int i = 0; i < 4; i ++) {
    fonts.add(createFont(i + ".otf", 128));
  }
  println("Movies Loaded");
  println("Fonts Loaded");
  println("Slice Cam Ready");

  scroll = new Scroller("WELCOME TO MIXED SIGNALS 2019", fonts);
  visual = new Visualizer(movies);

  mode = 1;
  background(0);
}

void movieEvent(Movie m) {
  if(mode == 1) {
    m.read();
  }
}

void captureEvent(Capture video) {
  if(mode == 2) {
   video.read(); 
  }
}

void draw() {
  if(frameCount % 600 == 0) {
    thread("getMessage");
  }
  

  switch(mode) {
  case 1:
    background(0);
    if (frameCount % 3600 == 0) {
      visual.update();
    }
    visual.display();
    scroll.display();
    scroll.update();
    break;

  case 2:
    scanner.display();
    break;

  default:
    break;
  }
}

void getMessage() {
  GetRequest get = new GetRequest("https://mixedsignalsrave.herokuapp.com/check");
  get.send();
  println("Response Context: " + get.getContent());

  scroll.text = get.getContent();
  if(scroll.hexIndex < 3) {
   scroll.hexIndex ++; 
  } else {
   scroll.hexIndex = 0; 
  }
}

void mousePressed() {
 switch(mode) {
  case 1:
    mode = 2;
    myCap.start();
    background(0);
    break;
  
  case 2:
    mode = 1;
    myCap.stop();
    break;
 }
}
