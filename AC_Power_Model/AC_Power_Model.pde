/*Modeling AC Power Systems with Resistive, Capacitive and Inductive Loads
 
 INSTRUCTIONS TO PLAY WITH LOADS & THEIR EFFECTS
 Press R to add a pure resisitive load to the system, F to completely remove that load
 Press C to incrementally add a capacitive load to the system, V to completely remove those loads
 Press I to incrementally add an inductive load to the system, K to completley remove those loads
 
 No Impedances are being calculated, instead I'm manipulating the PHASE angle between voltage and current
 to model the behavior when these various loads are added to the system
 
 */

PVector circle, voltage, current;
float d, r, theta, tSpeed, speed, t1, t2, t3;
ElectronSystem es;
PowerSystem ps;
float R, C, L;
PImage resistor, capacitor, inductor;

void setup() {
  size(1200, 400);
  d = 340;
  r = d/2;                              // radius in this case is analogous to voltage
  circle = new PVector(r/4, height/2);
  speed = .01;
  es = new ElectronSystem(); //creates particles for voltage and current curves
  ps = new PowerSystem();    //creates particles for power curve
  theta = 0;                 
  tSpeed = .02;
  resistor = loadImage("resistor.jpg");
  capacitor = loadImage("capacitor.png");
  inductor = loadImage("inductor.png");
}

void draw() {
  background(255);

  drawLabels();
  if (R+C+L > 0) {
    impedance();
    current();
    power();
  }
  noStroke();
  voltage();
  es.run();
  ps.run();
  theta += tSpeed;
}

PVector wave(float t, float _r) {
  return new PVector(circle.x + _r*cos(t), circle.y + _r*sin(t));
}

PVector pWave(float t, float t2, float _v, float _i) {
  println();
  //println(_v*_i*sin(t)*sin(t2));
  return new PVector(circle.x, circle.y - (_v*_i*sin(t)*sin(t2))/100);
}

void impedance() {
  if (R>0) {
    image(resistor, width-180, height/3.3, 200, 200);
    t2 = theta;
  } 
  else {
    t2 = theta + C - L;
  }
  if (C>0) {
    fill(0);
    textSize(20);
    text((int)C, width-320, height/4);

    image(capacitor, width-400, height/4, 200, 200);
  }
  if (L>0) {
    fill(0);
    textSize(20);
    text((int)L, width-510, height/4);
    image(inductor, width-600, height/14, 200, 200);
  }
}

void voltage() {
  voltage = wave(theta, r);
  // Voltage 'dot'
  fill(255, 0, 0);
  ellipse(circle.x, voltage.y, 10, 10);
  es.addParticle(theta, r, circle, speed, 1);
}

void current() {
  //Calculate and display current wave
  current = wave(t2, r/2);
  fill(0, 255, 0);
  ellipse(circle.x, current.y, 10, 10);
  es.addParticle(t2, r/2, circle, speed, 2);
}
void power() { 
  //Calculate and display power
  PVector power = pWave(theta, t2, r, r/2);
  fill(0, 0, 255);
  ellipse(circle.x, power.y, 10, 10);
  ps.addParticle(theta, t2, r, r/2, circle, speed, 3);
}


void keyPressed() {
  switch(key) {
  case 'c':
    C += PI/4;
    break;
  case 'v':
    C = 0;
    break;
  case 'i':
    //add inductive load
    L += PI/4;
    break;
  case 'k':
    //add inductive load
    L = 0;
    break;
  case 'r':
    //add resistive load
    R = 1;
    break;
  case 'f':
    //add resistive load
    R = 0;
    break;
  }
}

void drawLabels() {
  //legend
  fill(255, 0, 0);
  textSize(20);
  text("Voltage", width/6, 20);
  fill(0, 255, 0);
  textSize(20);
  text("Current", width/4, 20);
  fill(0, 0, 255);
  textSize(20);
  text("Power", width/3, 20 );

  //generator
  fill(255, 0, 0);
  rect(0, 0, r, 20);
  fill(255);
  textSize(20);
  text("+", r/2.2, 15);
  fill(128);
  rect(0, 380, r, 20);
  fill(0);
  textSize(20);
  text("-", r/2.2, 395);
  stroke(225);
  line(0, circle.y, width, circle.y);
}

