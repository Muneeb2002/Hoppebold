class Bold {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float xMouse;
  float yMouse;
  float dia = 15;
  float sut = 0;
  float jord;

  Bold(float m, float tempX, float tempY, float JordE) {
    mass = m;
    xMouse = tempX;
    yMouse = tempY;
    jord = JordE;
    location = new PVector(xMouse, yMouse);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }


  boolean hit ( Bold b) {
    float afstand = dist(b.location.x, b.location.y, location.x, location.y);
    // float afstandJord = dist(b.location.x, b.location.y);
    float minAfstand = b.dia+dia;

    boolean ligmed = (this == b); 

    if (minAfstand > afstand && !ligmed) {
      //println("Oscars mor");
      return(true);
    }

    return(false);
  }
  void move() {
    if (velocity.mag() >10) {
      velocity.normalize();
      velocity.mult(19);
    }
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0.9);
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  void edge() {
    if (location.x > width-1.5*dia) {
      location.x = width-1.5*dia;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    } else if (location.y > height-(1.5*dia)) {
      velocity.y *= -1;
      location.y = height-(1.5*dia);
    }
  }


  void display() {

    image(img2, location.x, location.y, dia*2*jord, dia*2*jord);
    noFill();
    stroke(255);
    circle(width/2, height*1.5, 900);
  }
  void jord() {
    float jordX = width/2;
    float jordY = height*1.5;
    float dx = jordX-location.x;
    float dy = jordY-location.y ;
    float distance = dist(location.x, location.y, width/2, height*1.5);
    float minDist = 450 + dia;
    if (distance < minDist) { 
      float angle = atan2(dy, dx);
      float targetX = xMouse + cos(angle) * minDist;
      float targetY = yMouse + sin(angle) * minDist;
      float ax = (targetX - location.x) * 0.5;
      float ay = (targetY - location.y) * 0.5;
      velocity.sub(new PVector (ax, ay));
    }
  }
}
