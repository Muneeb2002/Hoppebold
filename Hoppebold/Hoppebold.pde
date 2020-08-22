ArrayList<Bold> bolde;


void setup() {

  size(500, 500);
  bolde = new ArrayList<Bold>();
  bolde.add(new Bold(mouseX, mouseY));
}


void draw() {
  background(155);

  for (int i = 0; i < bolde.size(); i++) {
    bolde.get(i).move();
    bolde.get(i).display();
  }
}

void mousePressed() {
  bolde.add(new Bold(mouseX, mouseY));
}

class Bold {

  float xMouse;
  float yMouse;
  float xLoc = 0;
  float yLoc = 0;
  float xLocTemp = 0;
  float yLocTemp = 0;
  float xSpeed = 1;//random(0.5);
  float ySpeed = 3;//random(1.5, 3);
  float gravity = 0.3;
  float dia = 20;

  Bold(float tempX, float tempY) {
    xMouse = tempX;
    yMouse = tempY;
  }


  void move() {
    //  xLocTemp += xSpeed;
    // yLocTemp += ySpeed;
    xLoc += xSpeed;
    yLoc += ySpeed;
    ySpeed *= -0.9;
    //gravity+=gravity;


    if ((yMouse+yLoc > width)||yMouse+yLoc < 0) {       //Ændre yMouse+yLoc til yLoc = yMouse+yLocTemp
      ySpeed*=-1;
      //  gravity *=  -1;
    }
    if ((xMouse+xLoc > height)||xMouse+xLoc < 0) {       //Ændre yMouse+yLoc til yLoc = yMouse+yLocTemp
      xSpeed*=-1;
    }
   
   
     for (int i = 0; i < bolde.size();i++){
      for (int j = 0; i < bolde.size();j++){
       if (dist(bolde.get(i).xLoc,bolde.get(i).yLoc, bolde.get(j).xLoc,bolde.get(j).yLoc)<dia){
         println("din mor");
       }
      }
     }
  }
  void display() {
    fill(0);
    ellipseMode(CENTER);
    ellipse(xMouse+xLoc, yMouse+yLoc, dia, dia);
  }
}
