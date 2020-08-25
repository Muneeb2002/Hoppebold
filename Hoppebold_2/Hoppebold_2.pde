ArrayList<Bold> bolde;
PImage img;
PImage img2;

void setup() {
  frameRate(300);
  size(708, 495);
  img =loadImage("download.jpg");
  img2 = loadImage("Moon.png");
  bolde = new ArrayList<Bold>();
  bolde.add(new Bold(1,mouseY,mouseX,1));
}


void draw() {
  image(img, 0, 0, width, height);
  PVector gravity = new PVector(0, 0.1);
  mover();
  PVector wind = new PVector(0.01, 0);
  for (int i = 0; i < bolde.size(); i++) {
    bolde.get(i).move();
    bolde.get(i).applyForce(gravity);
    bolde.get(i).applyForce(wind);
    bolde.get(i).edge();
    bolde.get(i).display();
    bolde.get(i).jord();
  }
}

void mousePressed() {
    bolde.add(new Bold(1, mouseX, mouseY,1));
  
}

void keyPressed() {

  if (key == 'r') {
    frameCount=-1;
  }
}

void mover() {
  for (Bold b1 : bolde) {
    for (Bold b2 : bolde) {
      if (b1.hit(b2)) {
        float afstand = b1.location.dist(b2.location);
        //Hvor meget er de over hinanden?
        float overlap = 0.5 * (afstand - b1.dia - b2.dia);
        //Flyt dem så de ikke længere gør
        float flytX = overlap * (b1.location.x - b2.location.x) / afstand;
        float flytY = overlap * (b1.location.y - b2.location.y) / afstand; 

        b1.location.x -= flytX;
        b1.location.y -= flytY;

        b2.location.x += flytX;
        b2.location.y += flytY;



        /********** DYNAMISK OPFØRSEL *************/
        //Her håndteres der hastigheder og massr.

        //Ved ikke og jeg kan påvirke dem så ændrer dem ikke lige med det samme.
        PVector b1Coord = b1.location.copy(), 
          b2Coord = b2.location.copy();
        //Find vektoren mellem de to kolliderende kugler som svarer til normalen på kontaktfladen
        PVector normal = b1Coord.sub(b2Coord).normalize();
        //Find tangenten til de to cirkler (Hatter vektoren)
        PVector tangent = new PVector(-normal.y, normal.x);

        //Skal have opdelt begge hastigheder i x og y retning ved at prikke vektorerne med normalen og tangenten.
        //Her er det normalen som er vigtig, idet det forventes at kuglerne beholder tangenthastigheden (ved ikke om det er fysisk forsvarligt)
        float dpTan1 = b1.velocity.x * tangent.x + b1.velocity.y * tangent.y; 
        float dpTan2 = b2.velocity.x * tangent.x + b2.velocity.y * tangent.y;

        float dpNorm1 = b1.velocity.x * normal.x + b1.velocity.y * normal.y; 
        float dpNorm2 = b2.velocity.x * normal.x + b2.velocity.y * normal.y; 

        //Bruger ligningen for det fuldstændige elastiske stød: https://en.wikipedia.org/wiki/Elastic_collision
        float v1 = ((b1.mass - b2.mass) * dpNorm1 + 2.0f * b2.mass * dpNorm2) / (b1.mass + b2.mass);
        float v2 = (2 * b1.mass * dpNorm1 + (b2.mass - b1.mass) * dpNorm2) / (b1.mass + b2.mass);

        //Samlet set må den nye retning være følgende:
        b1.velocity.x = tangent.x * dpTan1 + normal.x * v1;
        b1.velocity.y = tangent.y * dpTan1 + normal.y * v1;

        b2.velocity.x = tangent.x * dpTan2 + normal.x * v2;
        b2.velocity.y = tangent.y * dpTan2 + normal.y * v2;
      //  println(v1);
      }
    }
  }
}
