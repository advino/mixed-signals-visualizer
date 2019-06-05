class Scroller {
  ArrayList<PFont> fonts;
  PFont activeFont[];

  String text;

  int x;
  int y;
  int add;
  
  color c;

  Scroller(String _text, ArrayList<PFont> _fonts) {
    fonts = _fonts;
    text = _text;
    x = 0;
    y = 0;
    add = 10;
    activeFont = new PFont[2];
    activeFont[0] = fonts.get(0);
    activeFont[1] = fonts.get(1);
    
    c = color(0,255,0);
  }

  void display() {
    for (int i = 128; i <= 2 * height; i += 128*2) {
      fill(c);
      textSize(128);
      textFont(activeFont[0]);
      textAlign(RIGHT);
      text(text, x, i);
      textFont(activeFont[1]);
      textAlign(LEFT);
      text(text, width - x, i + 128);
    }
  }

  void update() {

    if (x > 4 * width || x < 0) {
      add = -1 * add;
    }

    x += add;
  }
}
