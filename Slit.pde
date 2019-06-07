class Slit {

  Capture src;

  Slit(Capture _src) {
    src = _src;
  }

  void display() {
    pushMatrix();
    PImage img = src.get(0, frameCount % height, width, 1);
    image(img, 0, frameCount % height);
    
    PImage imgTwo = src.get(0, frameCount % height + 30, width, 1);
    image(imgTwo, 0, frameCount % height + 30);
    popMatrix();
  }
}
