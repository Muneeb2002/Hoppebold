ArrayList<Bold> bolde;


void setup() {

  size(500, 500);
  bolde = new ArrayList<Bold>();
  bolde.add(new Bold(random(1, 5), mouseX, mouseY));
}


void draw() {
  background(155);
  PVector gravity = new PVector(0, 0.1);
  PVector wind = new PVector(0.01, 0);
  for (int i = 0; i < bolde.size(); i++) {
    bolde.get(i).move();
    bolde.get(i).applyForce(gravity);
    bolde.get(i).applyForce(wind);
    bolde.get(i).edge();
    bolde.get(i).display();
  }
}

void mousePressed() {
  bolde.add(new Bold(random(1, 5), mouseX, mouseY));
}

class Bold {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float xMouse;
  float yMouse;
  float dia = 20;
  float sut = 0;



  Bold(float m, float tempX, float tempY) {
    mass = m;
    xMouse = tempX;
    yMouse = tempY;
    location = new PVector(xMouse, yMouse);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void move() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0.9);

    
 for (int i = 0; i < bolde.size(); i++) {
      for (int j = 0; j < bolde.size(); j++) {
        if (dist(bolde.get(i).location.x,bolde.get(i).location.y,bolde.get(j).location.x,bolde.get(j).location.y)< dia && dist(bolde.get(i).location.x,bolde.get(i).location.y,bolde.get(j).location.x,bolde.get(j).location.y) > 4){
          
          println(sut);
          sut++;
          bolde.get(i).acceleration.mult(-1);   // collision
          bolde.get(j).acceleration.mult(-1);
        }
      }
    }
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  void edge() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }

  void display() {
    ellipse(location.x, location.y, dia, dia);
  }
}
