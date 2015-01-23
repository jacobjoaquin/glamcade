// Perlin Generated Tunnel

import java.util.Iterator;

float tLeft = 0.0;
float tRight = 1000.0;
PVector ship;
ArrayList<PVector> blasts;

void setup() {
  size(500, 500);
  blasts = new ArrayList<PVector>();
  
  ship = new PVector(width / 2.0, height / 2.0);
}

void draw() {
  background(255);
  
  float blockSize = 50;

  fill(0);
  beginShape();
  float thisInc = 0.1;
  for (float x = 0; x <= width; x += blockSize) {
    float y = noise(tLeft + thisInc);
    y = constrain(y, -200, 200);
    float y2 = noise(tRight + thisInc);
    y2 = constrain(y, -200, 200);
    vertex(x, y * 200 + 300);
    vertex(x + blockSize, y * 200 + 300);
    thisInc += 0.15;
  }
  vertex(width, height);
  vertex(0, height);
  endShape();

  beginShape();
  thisInc = 0.1;
  for (float x = 0; x <= width; x += blockSize) {
    float y = noise(tRight + thisInc);
    y = constrain(y, -200, 200);
    vertex(x, y * 200 + 100);
    vertex(x + blockSize, y * 200 + 100);
    thisInc += 0.15;
  }
  vertex(width, 0);
  vertex(0, 0);
  endShape();

  drawShip();
  
  PVector bMag = PVector.fromAngle(0);
  bMag.mult(5);
//  for (PVector blast : blasts) {
//    pushStyle();
//    noStroke();
//    fill(255, 0, 0);    
//    ellipse(blast.x, blast.y, 4, 4);
//    blast.add(bMag);
//    popStyle();
//  }
  Iterator<PVector> blast = blasts.iterator();
  while(blast.hasNext()) {
    PVector b = blast.next();
    b.add(bMag);
    pushStyle();
    noStroke();
    fill(255, 0, 0);    
    ellipse(b.x, b.y, 4, 4);
    b.add(bMag);
    popStyle();
    if (b.x > width) {
      blast.remove();
      
    }
  }
  
  float tInc = 0.025;
  tLeft += tInc;
  tRight += tInc;
}

void drawShip() {
  pushStyle();
  fill(0);
  noStroke();
  triangle(ship.x, ship.y, ship.x - 40, ship.y + 10, ship.x - 40, ship.y - 10);
  popStyle(); 
}

void moveShip(float angle, float magnitude) {
       PVector p = PVector.fromAngle(angle);
       p.mult(magnitude);
       ship.add(p);       
}

void fire() {
  println(blasts.size());
  PVector s = ship.get();
  blasts.add(s);
  
  println(blasts.size());
}

void keyPressed() {
  float m = 10;

  if (key == CODED) {
    if (keyCode == RIGHT) {
      moveShip(0, m);
    }
    else if (keyCode == DOWN) {
      moveShip(PI / 2.0, m);
    }
    else if (keyCode == LEFT) {
      moveShip(PI, m);
    }
    else if (keyCode == UP) {
      moveShip(3 * PI / 2.0, m);
    }
  }
  else {
    if (key == 'f') {
      fire();
    }
  }
}
