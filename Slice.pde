class Slice {

  Capture src;
  float srcPt;
  int count;
  int index;
  PVector location;
  PVector velocity;
  PVector acceleration;

  int maxSpeed;
  float maxForce;

  Slice(Capture _src, float _srcPt) {
    src = _src;
    srcPt = _srcPt;
    count = 0;
    index = count % 640;
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    maxSpeed = 1;
    maxForce = .02;
  }

  PImage getSlice(Capture src) {

    PImage slice = src.get(int(srcPt), index, src.width/10, 3);
    return slice;
  }

  void update() {
    count++;
    index = count % 480;

    location.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    acceleration.mult(0);
  }

  void addForce(PVector force) {
    acceleration.add(force);
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    addForce(steer);
  }

  void borders() {
    if (location.x < 0) location.x = width;
    if (location.y < 0) location.y = height;
    if (location.x > width) location.x = 0;
    if (location.y > height) location.y = 0;
  } 
  
  void display() {
    PImage slice = getSlice(src);
    float theta = velocity.heading() + PI/2;
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    imageMode(CENTER);
    image(slice, 0, 0);
    popMatrix();
  }
}
